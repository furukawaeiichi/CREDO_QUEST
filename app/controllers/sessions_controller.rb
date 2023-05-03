class SessionsController < ApplicationController
  def create
    # ユーザー認証に失敗したら
    unless request.env['omniauth.auth'][:uid]
      flash[:danger] = '連携に失敗しました'
      redirect_to root_url
    end

    # 認証情報をuser_dataに格納
    user_data = request.env['omniauth.auth']
    # Userテーブルから、uidが一致するユーザーを検索
    user = User.find_by(uid: user_data[:uid])

    # ユーザーが見つかればログイン
    if user
      log_in user
      flash[:success] = 'ログインしました'
      redirect_to root_url
    else
      # ユーザーが見つからなければ新規登録
      new_user = User.new(
        uid: user_data[:uid],
        nickname: user_data[:info][:nickname],
        name: user_data[:info][:name],
        image: user_data[:info][:image],
      )
      # ユーザー登録に成功したらログイン
      if new_user.save
        log_in new_user
        flash[:success] = 'ユーザー登録成功'
      else
        # ユーザー登録に失敗したら
        flash[:danger] = '予期せぬエラーが発生しました'
      end
      redirect_to root_url
    end
  end

  # ログアウト
  def destroy
    log_out if logged_in?
    flash[:success] = 'ログアウトしました'
    redirect_to root_url
  end

  # private 後にリファクタリングする
  # def auth_params
  #   request.env['omniauth.auth']
  # end
end
