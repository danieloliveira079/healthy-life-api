class SessionsController < ApplicationController
  skip_before_action :authenticate!, only: [:create, :signup, :recovery]
  before_action :set_email, only: [:recovery]

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

  def recovery
    if user_exists?
      send_email @email
      render status: :ok, json: ""
    else
      render status: :unprocessable_entity, json: ""
    end
  end

  def destroy
    TokenIssuer.expire_token(current_user, request) if current_user
    render status: :ok, json: ""
  end

  private

    def send_email email
      
    end

    def session_params
      params.require(:user).permit(:email, :password)
    end

    def set_email
      @email = params.require(:user).permit(:email)[:email]
    end

    def user_exists?
      User.find_by(email: @email)
    end

end
