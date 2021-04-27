class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[index edit update destroy]
  before_action :correct_user,   only: %i[edit update]
  before_action :admin_user,     only: :destroy

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = 'User deleted'
    redirect_to users_url
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.update_attribute(:tokens, 500) # added line to users to give them 500 tokens on start
      reset_session
      log_in @user
      flash[:success] = 'Success! Welcome to blackjack'
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'Success! Profile updated'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def add_tokens
    if current_user.tokens >= 100
      flash[:danger] = 'Sorry, but you already have a sufficient amount of tokens!'
    else
      current_user.update_attribute(:tokens, current_user.tokens + 100)
      flash[:success] = 'Success! 100 tokens were added to your account!'
    end
    redirect_to current_user
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  # Confirms an admin user.
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  # Before filters

  # Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = 'Please log in.'
      redirect_to login_url
    end
  end

  # Confirms the correct user.
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
end
