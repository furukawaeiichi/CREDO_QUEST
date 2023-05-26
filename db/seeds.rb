# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

user = User.create!(provider: "provider_name", uid: "uid", nickname: "nickname", name: "name", image: "image_url")

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
      "本当に困っていることは、ヘルプを出せるようになろう！",
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
