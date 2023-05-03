class User < ApplicationRecord
  # 引数として認証情報(auth)を受け取り、
  def self.find_or_create_from_auth(auth)
    uid = auth[:uid]
    nickname = auth[:info][:nickname]
    name = auth[:info][:name]
    image = auth[:info][:image]

    # uidが一致するUserを検索、なければ作成
    self.find_or_create_by(uid: uid) do |user|
      user.name = auth[:info][:name]
      user.nickname = auth[:info][:nickname]
      user.image = auth[:info][:image]
    end
  end
end
