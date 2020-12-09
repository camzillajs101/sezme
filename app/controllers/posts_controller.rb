class PostsController < ApplicationController
  before_action :authenticate_user!, only: :new

  def index
  end

  def show
  end

  def new
  end
end
