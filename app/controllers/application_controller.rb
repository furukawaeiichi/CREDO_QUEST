class ApplicationController < ActionController::Base
  include SessionsHelper  # module SessionsHelperが全てのコントローラーで使えるようになる
  protect_from_forgery with: :exception # CSRF攻撃から保護する
end
