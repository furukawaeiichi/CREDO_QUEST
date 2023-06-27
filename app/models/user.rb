class User < ApplicationRecord

  has_many :lists, dependent: :destroy
  has_many :todos, through: :lists
  has_many :tasks, through: :lists
  has_many :likes, dependent: :destroy
  has_many :liked_tasks, through: :likes, source: :task

  paginates_per 15

  def level
    self.lists.sum { |list| list.todos.where(checked: true).count + list.tasks.where(checked: true).count }
  end

  def already_liked?(task)
    self.likes.exists?(task_id: task.id)
  end

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

end
