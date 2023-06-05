class UsersController < ApplicationController
  before_action :authenticate_user!               # サインインしていなければ、root_pathにリダイレクト
  before_action :logged_in_user, only: [:index, :show]
  before_action :correct_user,   only: [:edit, :update, :destroy]

  def show
    @user = User.find(params[:id])                # params[:id]でユーザーを探す
    @lists = @user.lists
    @task = Task.new                              # 新しいタスクを作成
    @user_tasks = @user.tasks.order(id: :desc)    # ユーザーのタスクを新しい順に並べる
  end
end
