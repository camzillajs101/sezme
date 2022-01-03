class GroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @groups = current_user.groups
  end

  def show
    @group = Group.find(params[:id])
    verify_ownership(@group)
  end

  def new
    @group = current_user.groups.new
  end

  def create
    @group = current_user.groups.new(group_params)

    if @group.save
      redirect_to @group
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
    verify_ownership(@group)
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
end
