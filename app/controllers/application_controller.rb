class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception                     # csrf攻撃から守る
  helper_method :current_user, :user_signed_in?             # current_user, user_signed_in?をviewでも使えるようにする

  private

  def authenticate_user!                                    # サインインしていなければ
    redirect_to root_path unless session[:user_id]          # セッションにuser_idがなければ、root_pathにリダイレクト
  end

  def current_user                                          # 現在のユーザーを取得
    return unless session[:user_id]                         # セッションにuser_idがなければ、何もしない
    @current_user ||= User.find_by(uid: session[:user_id])  # @current_userがなければ、Userテーブルからuser_idを探して代入する
  end

  def user_signed_in?                                       # サインインしているか確認
    !!session[:user_id]                                     # セッションにuser_idがあればtrue、なければfalseを返す
  end
end
