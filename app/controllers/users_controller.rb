class UsersController < ApplicationController
  before_action :authenticate_user!         # サインインしていなければ、root_pathにリダイレクト

  def show
    @user = User.find(params[:id])          # params[:id]でユーザーを探す
  end

  def boards
    render "boards/index"
  end
end
