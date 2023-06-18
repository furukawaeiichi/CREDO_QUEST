class AddExternalLinksToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :github, :string
    add_column :users, :mattermost, :string
    add_column :users, :notion, :string
    add_column :users, :note, :string
    add_column :users, :hatena_blog, :string
    add_column :users, :qiita, :string
    add_column :users, :zenn, :string
  end
end
