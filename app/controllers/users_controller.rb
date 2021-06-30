class UsersController < ApplicationController
  before_action :authenticate_admin!, only: :index

  def show
    @user = User.where(username: params[:username]).first
  end

  def index
    @users = User.all.order(id: :asc)
  end
end
