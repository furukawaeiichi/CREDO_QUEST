class UsersController < ApplicationController
  before_action :authenticate_user!               # サインインしていなければ、root_pathにリダイレクト

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])                # params[:id]でユーザーを探す
    if current_user == @user                      # ログインしているユーザーと、表示しているユーザーが同じなら
      @task = Task.new                            # 新しいタスクを作成
    end
    @lists = @user.lists
    @user_tasks = @user.tasks.order(id: :desc)    # ユーザーのタスクを新しい順に並べる
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:notice] = "情報が更新されました！"
      redirect_to edit_user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    reset_session
    flash[:success] = "アカウントを削除しました"
    redirect_to root_path, status: :see_other
  end

  def user_params
    params.require(:user).permit(:github, :mattermost, :notion, :note, :hatena_blog, :qiita, :zenn)
  end
end
