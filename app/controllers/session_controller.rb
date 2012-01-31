class SessionController < ApplicationController

  def new
    redirect_to '/auth/github'
    # redirect_to '/auth/twitter'
  end

  # def create
  #   raise request.env["omniauth.auth"].to_yaml
  # end

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_url, :notice => "User #{user.name} signed in through #{user.provider}"

    # auth = request.env["omniauth.auth"]
    # # logger.info("OMNIAUTH_AUTH: #{auth.to_json}")
    # # or User.find_or_create_by
    # user = User.where(:provider => auth['provider'], :uid => auth['uid']).first ||
    #   User.create_with_omniauth(auth)
    # session[:user_id] = user.id
    # redirect_to root_url, :notice => "User #{user.name} signed in through #{user.provider}"
  end

  def destroy
    # session[:user_id] = nil
    reset_session
    redirect_to root_url, :notice => "User signed out!"
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

end
