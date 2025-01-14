class SessionsController < ApplicationController
  def create
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      render json: user, status: :created
    else
      render json: {login: "Invalid username or password"}, status: :unauthorized
    end
  end

  def destroy
    #user = User.find_by(username: params[:username])
    #user&.authenticate(params[:password])
    session.delete :user_id
    head :no_content
  end
end
