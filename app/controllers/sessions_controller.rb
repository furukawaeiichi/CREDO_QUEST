class SessionsController < ApplicationController

  def create                                                            # サインインしたら
    user = User.find_or_create_from_auth(request.env["omniauth.auth"])  # userを認証情報から探す、なければ作る
    session[:user_id] = user.uid                                        # user_idをセッションに入れる
    redirect_to user_path(user.id)                                      # user_pathにリダイレクト
  end

  def destroy                                                           # サインアウトしたら
    reset_session                                                       # セッションをリセット
    redirect_to root_url, status: :see_other                            # 303を設定して、turboの誤削除を防ぐ
  end

  def failure                                                           # 認証失敗したら
    redirect_to root_url                                                # root_urlにリダイレクト
  end
end
