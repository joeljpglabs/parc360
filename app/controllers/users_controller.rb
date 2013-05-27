class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_filter :correct_user, only: [:edit, :update, :accounts]
  before_filter :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts =  @user.microposts.paginate(page: params[:page])
    @user_accounts = @user.user_accounts.paginate( page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new( params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to PARC360!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    logger.info "User is #{@user.name}"
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile Updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find( params[:id])
    @users = @user.followers.paginate( page: params[:page])
    render 'show_follow'
  end

  def accounts
    @user = User.find( params[:id] )
    @user_accounts = @user.user_accounts.paginate(page: params[:page])
    @user_account = @user.user_accounts.build
    render 'show_accounts'
  end

  private
    #correct_user gets invoked by the before_filter, which means that we don't have to do the lookup in the edit and
    #delete because the @user is already set
    def correct_user
      @user = User.find( params[:id])
      redirect_to(root_path) unless current_user?( @user )
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

end
