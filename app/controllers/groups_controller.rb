class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_ownership, only: [:show, :edit]

  def index
    @groups = current_user.groups
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new

    if @group.save
      current_user.groups << @group
      redirect_to @group
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])

    if @group.update
      redirect_to @group
    else
      render :edit
    end
  end

  def destroy
    Group.find(params[:id]).destroy
    redirect_to groups_path
  end

  protected
    def group_params
      params.require(:group).permit(:title)
    end
    def verify_ownership
      group = Group.find(params[:id])
      if !current_user.groups.exists?(group)
        redirect_to group
      end
    end
end
