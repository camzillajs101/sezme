class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]

  def index
    # if user_signed_in? && current_user.sign_in_count == 0 # for new users
    #   redirect_to "/pages/welcome"
    # end

    @posts = Post.order(id: :asc)
  end

  def show
    @post = Post.find(params[:id])
    @reviews = @post.reviews.all
    @review = @post.reviews.new
    @user = User.find(@post.user_id)
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

  def edit
    @post = Post.find(params[:id])
    if @post.user_id != current_user.id
      redirect_to @post
    end
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to @post
    else
      render :edit
    end
  end

  private
    def post_params
      params.require(:post).permit(:title, :desc, :rating, :url)
    end
end
