class V1::UsersController < V1::BaseController
  def create
    @user = User.create(user_params)
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
