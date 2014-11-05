class V1::UsersController < V1::BaseController
  before_action :set_user, only: [:update, :show]
  before_action :authorize, only: [:update, :show]

  def show
  end

  def create
    @user = User.create(user_params)
    respond_with @user
  end

  def update
    @user.update(user_params)
    respond_with @user
  end

  private

  def user_params
    params.permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def authorize
    unless @user == current_user
      head :unauthorized
    end
  end
end
