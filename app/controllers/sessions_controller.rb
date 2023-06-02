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
          "同期のtimesをチェックする習慣をつけよう！",
          "すぐ返事しよう！（できない時はスタンプ）",
          "わからないことをメモして、わかるようになったらチェックしよう！（成功脳・学習の見える化）",
          "紙やtimesに分からないことを書き出して、問題を分解しよう！",
          "1日1つ学んだこと(単語の意味など)を発信しよう！",
          "バトランのアーカイブを観て、自分なりの目標を決めよう！",
          "どんなWebアプリを作ってみたいか、メモにアイデアを貯めよう！",
          "Githubの草を、1週間毎日生やそう！",
          "2−3割ですぐプロトタイプを出す、FBをもらおう！",
          "「思考する時間」と「作業する時間」を分けよう！"
        ]
      },
      {
        title: "Give First",
        todos: [
          "他の受講生のtimesに、コメントorスタンプしよう！",
          "頑張っている人を、Mattermost「Nice Active !」で投票しよう！",
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
          "学んだ技術が、どんなサービスに使われるか結びつけよう！",
          "rails newして、簡単な機能を3つ作ろう！（カリキュラム外）",
          "技術ブログを書いてみよう！（NotionやQiita等）",
          "LT会で学んだことを発表しよう！",
          "新しい技術の記事や本を読んでみよう！",
          "Webアプリを技術ブログにまとめよう！",
          "他の受講生と、お互いのWebアプリをコードレビューをしよう！",
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
