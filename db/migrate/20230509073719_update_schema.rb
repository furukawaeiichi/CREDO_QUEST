class UpdateSchema < ActiveRecord::Migration[7.0]
  def change
    change_column_default :todos, :checked, false

    add_index :users, [:provider, :uid], unique: true
  end
end
