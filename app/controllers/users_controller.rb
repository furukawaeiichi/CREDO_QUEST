class UsersController < ApplicationController
  before_action :authenticate_user!               # サインインしていなければ、root_pathにリダイレクト

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])                # params[:id]でユーザーを探す
    @lists = @user.lists
    @task = Task.new                              # 新しいタスクを作成
    @user_tasks = @user.tasks.order(id: :desc)    # ユーザーのタスクを新しい順に並べる
  end
end
