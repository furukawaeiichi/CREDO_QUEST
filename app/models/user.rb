class User < ApplicationRecord

  def self.find_or_create_from_auth(auth)                             # 引数として認証情報(auth)を受け取り、
    provider = auth[:provider]
    uid = auth[:uid]
    nickname = auth[:info][:nickname]
    name = auth[:info][:name]
    image = auth[:info][:image]
    self.find_or_create_by(provider: provider, uid: uid) do |user|    # providerとuidが一致するレコードがあれば返す、なければ作成して返す
      user.nickname = auth[:info][:nickname]
      user.name = auth[:info][:name]
      user.image = auth[:info][:image]
    end
  end

  has_many :lists
  has_many :todos, through: :lists

end
