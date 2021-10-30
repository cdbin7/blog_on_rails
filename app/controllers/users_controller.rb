class UsersController < ApplicationController
  def new
    @user = User.new
  end


  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Logged In"
    else
      render :new
    end
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    if @user.update params.require(:user).permit(:name, :email)
      redirect_to root_path
    else
      render :edit
      flash[:alert] = @user.errors.full_messages
    end
  end

  def edit_password
    @user = User.find params[:user_id]
  end

  
  def update_password
    @user = User.find params[:user_id]
    
    if @user.authenticate(params[:password])
      if params[:new_password] != params[:password] && params[:new_password] === params[:new_password_confirmation]
        # @user = User.update params.permit(:password, :new_password, :new_password_confirmation)
        # @user = User.update(:password => :new_password)
        @user.update(password: params[:new_password])
        flash[:notice] = "Password is successfully updated!"
        redirect_to root_path
      else
        flash[:alert] = "Your new password should not be same as previous one or type new password correctly"
        render :edit_password
      end
    else
      flash[:alert] = "Your password is not matching"
      render :edit_password
    end
  end

  private
  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation
      )
  end

end
