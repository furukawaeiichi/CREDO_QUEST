class SessionsController < ApplicationController

  def create                                                            # サインインしたら
    user = User.find_or_create_from_auth(request.env["omniauth.auth"])  # userを認証情報から探す、なければ作る
    session[:user_id] = user.uid                                        # user_idをセッションに入れる
    create_default_lists_and_todos(user) if user.lists.empty?
    redirect_to user_path(user.id)                                      # user_pathにリダイレクト
  end

  def destroy                                                           # サインアウトしたら
    reset_session                                                       # セッションをリセット
    redirect_to root_url, status: :see_other                            # 303を設定して、turboの誤削除を防ぐ
  end

  def failure                                                           # 認証失敗したら
    redirect_to root_url                                                # root_urlにリダイレクト
  end

  private

  def create_default_lists_and_todos(user)

    my_quest = List.create!(title: "マイクエスト", user_id: user.id)
    list_data = [
      {
        title: "Be Open",
        todos: [
          "Twitterやtimesで、目標を投稿しよう！",
          "わからない所を、恥ずかしがらずにtimesに書こう！",
          "同期限定イベントに参加してみよう！",
          "全体懇親会に参加してみよう！",
          "他の受講生と、どんなエンジニアになりたいか喋ってみよう！",
          "本当に困っていることや悩みは、必ずヘルプを出そう！",
          "成功体験や失敗談からの学びを発信しよう！（Noteなど）",
          "他の受講生と、技術面談の練習をしよう！",
          "checkbox9",
          "checkbox10"
        ]
      },
      {
        title: "Move Fast",
        todos: [
          "同期のtimesをチェックしよう！",
          "すぐ返事しよう！（できない時はスタンプ）",
          "今日学んだことをtimesに書こう！",
          "紙やtimesに分からないことを書き出して、問題を分解しよう！",
          "バトランのアーカイブを観て、自分なりの目標を決めよう！",
          "どんなWebアプリを作ってみたいか、アイデア帳にメモしよう！",
          "Githubの草を、1週間毎日生やそう！",
          "checkbox8",
          "checkbox9",
          "checkbox10"
        ]
      },
      {
        title: "Give First",
        todos: [
          "他の受講生のtimesに、コメントorスタンプしよう！",
          "頑張っている人を、Mattermost「Nice Active !」投票しよう！",
          "他の受講生がわからない問題を、一緒に考えてみよう！",
          "Discord「救済部屋」のメッセージ欄から協力しよう！",
          "自分が後輩のわからないところを教えてみよう！",
          "他の受講生のWebアプリを触って、Twitterで感想をつぶやこう！",
          "就活・面談のふりかえりをtimesで発信しよう！",
          "checkbox8",
          "checkbox9",
          "checkbox10"
        ]
      },
      {
        title: "Geek Out",
        todos: [
          "フォーマットを埋めて、質問の初投稿しよう！",
          "自分のtimesに学んだ知識を書いてみよう！",
          "技術ログを書いてみよう！（NotionやQiita等）",
          "rails newして、簡単な機能を3つ作ろう！（カリキュラム外）",
          "LT会で学んだことを発表しよう！",
          "新しい技術の記事や本を読んでみよう！",
          "Webアプリを技術ブログにまとめよう！",
          "他の受講生と、お互いのWebアプリコードレビューをしよう！",
          "checkbox9",
          "checkbox10"
        ]
      },
      {
        title: "Take Ownership",
        todos: [
          "イベントに参加してみよう！",
          "自分のモチベーションが上がるフックを見つけよう！",
          "今週の立てた目標を達成しよう！",
          "もくもく会を開催してみよう！",
          "LT会に登壇しよう！",
          "スクール外のエンジニアイベントに参加しよう！",
          "checkbox7",
          "checkbox8",
          "checkbox9",
          "checkbox10"
        ]
      }
    ]

    list_data.each do |list|
      created_list = List.create!(title: list[:title], user_id: user.id)

      list[:todos].each do |todo|
        Todo.create!(content: todo, list_id: created_list.id, user_id: user.id)
      end
    end
  end

end
