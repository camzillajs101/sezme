class ReviewsController < ApplicationController
  def show
    @review = Review.find(params[:id])
    @post = Post.find(@review.post_id)
    @user = User.find(@post.user_id)
    @replies = @review.replies.order(created_at: :asc)
  end

  def create
    @post = Post.find(params[:post_id])
    @review = @post.reviews.new(review_params)

    if @review.save
      redirect_to @post
    else
      
    end
  end

  def edit
    @review = Review.find(params[:id])
    @post = @review.post
  end

  def update
    @review = Review.find(params[:id])

    if @review.update(review_params)
      redirect_to @review
    else
      render :edit
    end
  end

  def destroy
    @review = Review.find(params[:id])

    @review.destroy
    redirect_to @post
  end

  private
    def review_params
      params.require(:review).permit(:title, :desc, :rating).merge(user_id: current_user.id)
    end
end
