class SessionsController < ApplicationController

  def create
    auth = request.env['omniauth.auth']
    if auth.present?
      user = User.find_auth(request.env['omniauth.auth'])
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
      # if user = User.find_by(session_params)
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

  # private
  #
  # def session_params
  #   params.require(:session).permit(:email, :password_digest)
  # end

end
