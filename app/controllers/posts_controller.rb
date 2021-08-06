class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]

  def index
    # if user_signed_in? && current_user.sign_in_count == 0 # for new users
    #   redirect_to "/pages/welcome"
    # end

    case params[:sort]
    when "new"
      @posts = Post.order(id: :desc)
    when "popular"
      # sort it by score or something in the future
      @posts = Post.order(id: :asc)
    when "most_reviews"
      # no idea how this works
      @posts = Post.left_joins(:reviews).group(:id).order('COUNT(reviews.id) DESC').limit(10)
    when "highest_rating"

    else
      @posts = Post.order(id: :asc)
    end
  end

  def show
    @post = Post.find(params[:id])
    case params[:sort]
    when "new"
      @reviews = @post.reviews.order(created_at: :desc)
    when "old"
      @reviews = @post.reviews.order(created_at: :asc)
    when "rate_high"
      @reviews = @post.reviews.order(rating: :desc)
    when "rate_low"
      @reviews = @post.reviews.order(rating: :asc)
    else
      @reviews = @post.reviews.order(id: :asc)

      # if user_signed_in?
      #   @reviews = @post.reviews.find(user_id: current_user.id)
      # else
      #   @reviews = @post.reviews.order(id: :asc)
      # end
    end
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
