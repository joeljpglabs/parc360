class UserAccountsController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, only: [:destroy]

  def create
    @user_account = current_user.user_accounts.build(params[:user_account])
    if @user_account.save
      flash[:success] = "Account added!"
      redirect_back_or current_user
    else
      @feed_items = [];
      render 'static_pages/home'
    end
  end

  def destroy
    @user_account.destroy
    redirect_back_or current_user
  end

  private
    def correct_user
      @user_account = current_user.user_accounts.find_by_id( params[:id])
      redirect_to root_url if @user_account.nil?
    end
end
