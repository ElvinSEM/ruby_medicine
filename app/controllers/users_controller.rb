class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(user_params)
    binding.pry
    if @user.save
      redirect_to @user, notice: "User  успешно создан."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to @user, notice: "User был успешно обновлен.", status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    binding.pry

    @user.destroy
    redirect_to destroy_user_session_url, notice: "User был успешно удален.", status: :see_other
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :email, :password_, :digest)
    end
end

#
# class UsersController < ApplicationController
#   before_action :authenticate_user!, only: [:index, :show]
#   before_action :set_user, only: [:show]
#
#   # GET /users
#   # Этот метод может использоваться для отображения списка пользователей,
#   # если такая функциональность требуется в вашем приложении.
#   def index
#     @users = User.all
#   end
#
#   # GET /users/1
#   # Этот метод может использоваться для просмотра профилей пользователей,
#   # если такая функциональность требуется в вашем приложении.
#   def show
#   end
#
#   private
#
#   # Use callbacks to share common setup or constraints between actions.
#   def set_user
#     @user = User.find(params[:id])
#   end
# end