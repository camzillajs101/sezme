class PostsController < ApplicationController
  before_action :authenticate_user!, only: :new

  def index
    @posts = Post.order(id: :asc)
  end

  def show
    @post = Post.find(params[:id])
    @reviews = @post.reviews.all # Review.where(post_id: params[:id])
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to @post
    else
      render :new
    end
  end

  private
    def post_params
      params.require(:post).permit(:title, :desc, :rating)
    end
end
