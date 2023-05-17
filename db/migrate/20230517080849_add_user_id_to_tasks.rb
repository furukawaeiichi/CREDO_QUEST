class AddUserIdToTasks < ActiveRecord::Migration[7.0]
  def change
    add_reference :tasks, :user, null: false, foreign_key: true
    add_reference :todos, :user, null: false, foreign_key: true
  end
end
