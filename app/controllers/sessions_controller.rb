class SessionsController < ApplicationController

  def create
    auth = request.env['omniauth.auth']
    if auth.present?
      user = User.find_or_create_from_auth(request.env['omniauth.auth'])
      login user
      # redirect_to user_url(user)
      redirect_to root_path
    else
      if user = User.find_by(session_params)
        login user
        redirect_to user_url(user)
      else
        flash.now[:danger] = 'Invalid email/password combination'
        render 'new'
      end
    end
  end

  def destroy
    logout
    redirect_to root_url
  end

  private

  def session_params
    params.require(:session).permit(:email, :password_digest)
  end

end
