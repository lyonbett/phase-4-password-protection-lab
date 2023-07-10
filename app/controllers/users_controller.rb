class UsersController < ApplicationController
  before_action :set_user, only: [:update, :destroy]
  skip_before_action :set_user, only: [:show]
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    user = User.find_by(id: session[:user_id])
    if user
     render json: user
    else
      render json: {errors: "Not authorized"}, status: :unauthorized
    end
  end

  # POST /users
  def create
    user = User.create!(user_params)
    session[:user_id] = user.id
    render json: user, status: :created
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.permit(:username, :password, :password_confirmation)
    end

    def render_unprocessable_entity(invalid)
      render json: {error: invalid.record.errors}, status: :unprocessable_entity
    end

end
