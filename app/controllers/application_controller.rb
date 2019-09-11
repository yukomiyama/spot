class ApplicationController < ActionController::Base
  include SessionsHelper

  #beforeアクション
  #ログイン済みユーザーかどうか確認
  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end
