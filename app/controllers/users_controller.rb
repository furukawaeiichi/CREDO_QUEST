class UsersController < ApplicationController
  before_action :authenticate_user!         # サインインしていなければ、root_pathにリダイレクト

  def show
    @user = User.find(params[:id])          # params[:id]でユーザーを探す
    @tasks = @user.tasks.order(id: :desc)   # ユーザーのタスクを新しい順に並べる
  end
end
