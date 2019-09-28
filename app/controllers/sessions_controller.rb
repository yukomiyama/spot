class SessionsController < ApplicationController
  def new
  end

  def create
    if user = User.find_by(session_params)
      login user
      redirect_to user_url(user)
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
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
