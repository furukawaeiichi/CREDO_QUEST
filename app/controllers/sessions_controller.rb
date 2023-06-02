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
          "卒業までの目標を投稿しよう！（Twitter, timesなど）",
          "わからない所を、恥ずかしがらずにtimesに書こう！",
          "自分の良いor悪い習慣をシェアしてより良くしよう！（Twitter, timesなど）",
          "同期限定イベントに参加して、10人と喋ろう！（Twitter, timesなどフォローしよう！）",
          "全体懇親会に参加して、10人と喋ろう！（Twitter, timesなどフォローしよう！）",
          "他の受講生と「どんなエンジニアになりたいか」「そのために何をするべきか」喋ってみよう！",
          "作ってみたいWebアプリの案や構想についてFBもらおう！",
          "本当に困っていることや悩みは、必ずヘルプを出そう！（timesなど）",
          "成功体験や失敗談からの学びを発信しよう！（note, Notionなど）",
          "他の受講生と技術面談の練習をしよう！"
        ]
      },
      {
        title: "Move Fast",
        todos: [
          "同期のtimesをチェックする習慣をつけよう！",
          "すぐ返信しよう！（できない時はスタンプ）",
          "わからないことをメモして、わかるようになったらチェックしよう！（成功脳・学習の見える化）",
          "紙やtimesに分からないことを書き出して、問題を分解しよう！",
          "1日1つ学んだこと（単語の意味など）を発信しよう！",
          "バトランのアーカイブを観て、自分なりの目標を決めよう！",
          "どんなWebアプリを作ってみたいか、メモにアイデアを貯めよう！",
          "Githubの草を、1週間毎日生やそう！",
          "すぐプロトタイプを出して、早くFBをもらおう！",
          "「思考する時間」と「作業する時間」を分けよう！"
        ]
      },
      {
        title: "Give First",
        todos: [
          "他の受講生のtimesに、コメントorスタンプしよう！",
          "人のためになる情報（記事や本、イベントなど）をシェアしよう！",
          "頑張っている人を、Mattermost「Nice Active !」で投票しよう！",
          "グループワークに自分の得意なことで貢献しよう！",
          "他の受講生がわからない問題を、一緒に考えてみよう！",
          "Discord「救済部屋」のメッセージ欄から協力しよう！",
          "後輩のわからないところを教えてみよう！",
          "カリキュラムで自分が詰まった部分を解説しよう！（Notion, Qiita, LT会など）",
          "他の受講生のWebアプリを触って、Twitterで感想をつぶやこう！",
          "就活・面接のふりかえりをtimesで発信しよう！"
        ]
      },
      {
        title: "Geek Out",
        todos: [
          "フォーマットを埋めて、質問の初投稿しよう！",
          "自分のtimesに学んだ知識を書いてみよう！",
          "学んだ技術が日常のどんな所で使われるか、結びつけながら学ぼう！",
          "カリキュラムで学んだことで、簡単なオリジナルアプリを作ろう！",
          "技術ブログを書いてみよう！（Notion, Qiitaなど）",
          "LT会で学んだことを発表しよう！",
          "新しい技術の記事や本を読んでみよう！",
          "積読した本の輪読会を開催or参加しよう！",
          "Webアプリを技術ブログにまとめよう！",
          "他の受講生と、お互いのWebアプリをコードレビューをしよう！"
        ]
      },
      {
        title: "Take Ownership",
        todos: [
          "決まった曜日・時間帯、Discordに繋いでもくもくしよう！",
          "ポモドーロタイマーを使って、集中力を高めよう！",
          "今日やることを書き出して、いくつできたかチェックしよう！（成功脳・進捗の見える化）",
          "今週の立てた目標を達成しよう！",
          "今月のよかったこと・カイゼンできることを振り返ろう！",
          "もくもく会などイベントを開催してみよう！",
          "同期生と「カリキュラムの理解を深める勉強会」をしよう！",
          "腰痛・不眠などの身体・精神的不調は、放置せずに予防・治療しよう！",
          "気になるアプリが使っている言語や技術を調べてみよう！",
          "気になる企業のエンジニアイベントに参加しよう！"
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
