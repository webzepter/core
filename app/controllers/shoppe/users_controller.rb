class Shoppe::UsersController < Shoppe::ApplicationController
  
  before_filter { @active_nav = :users }
  before_filter { params[:id] && @user = Shoppe::User.find(params[:id]) }
  
  def index
    @users = Shoppe::User.all
  end
  
  def new
    @user = Shoppe::User.new
  end
  
  def create
    @user = Shoppe::User.new(safe_params)
    if @user.save
      redirect_to :users, :flash => {:notice => "User has been created successfully"}
    else
      render :action => "new"
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(safe_params)
      redirect_to [:edit, @user], :flash => {:notice => "User has been updated successfully"}
    else
      render :action => "edit"
    end
  end
  
  def destroy
    raise Shoppe::Error, "You cannot remove yourself" if @user == current_user
    @user.destroy
    redirect_to :users, :flash => {:notice => "User has been removed successfully"}
  end
  
  private
  
  def safe_params
    params[:user].permit(:first_name, :last_name, :email_address, :password, :password_confirmation)
  end
  
end
