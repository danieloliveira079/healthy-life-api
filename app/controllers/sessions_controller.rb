class SessionsController < ApplicationController
  skip_before_action :authenticate!, only: [:create, :signup]

  # /login
  def create
    user = User.find_by(email: session_params[:email])
    if user && user.authenticate(session_params[:password])
      token = TokenIssuer.create_and_return_token(user, request)
      render status: :ok, json: { user_email: user.email, auth_token: token }
    else
      render status: :unauthorized, json: ""
    end
  end

  def signup
    @user = User.new(session_params)
    if @user.save
      token = TokenIssuer.create_and_return_token(@user, request)
      render status: :ok, json: { user_email: @user.email, auth_token: token }
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    TokenIssuer.expire_token(current_user, request) if current_user
    render status: :ok, json: ""
  end

  private

    def session_params
      params.require(:user).permit(:email, :password)
    end

    def user_exists?
      User.find_by(email: session_params[:email])
    end

end
