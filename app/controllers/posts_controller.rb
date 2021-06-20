class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]

  def index
    if params[:query]
      # @posts = Post.tagged_with(params[:query])
      @title_match = Post.where("title like ?","%#{params[:query]}%")
      @tag_match = Post.tagged_with(params[:query])
      @posts = (@title_match + @tag_match).uniq
    else
      @posts = Post.order(id: :asc)
    end
  end

  def show
    @post = Post.find(params[:id])
    @tags = @post.tag_list
    @reviews = @post.reviews.all
    @user = User.find(@post.user_id)

    # new review
    @review = @post.reviews.new
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

  def search
    @posts = Post.tagged_with(params[:query])
    
  end

  private
    def post_params
      params.require(:post).permit(:title, :desc, :rating, :tag_list)
    end
end
