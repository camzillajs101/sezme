class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]

  def index
    # if user_signed_in? && current_user.sign_in_count == 0 # for new users
    #   redirect_to "/pages/welcome"
    # end

    @posts = Post.sort(params[:sort])
  end

  def show
    @post = Post.find(params[:id])
    @post.punch(request)
    @user = User.find(@post.user_id)
    @reviews = Review.sort(@post, params[:sort])
    @review = @post.reviews.new
    if user_signed_in?
      @post_vote = @post.votes.find_by(user_id: current_user.id)
      @user_review = @reviews.find_by(user_id: current_user.id)
    end

    if params[:exception]
      @reviews = @reviews.where(rating: params[:exception].to_i * 10)
    end
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
    verify_ownership(@post)
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
