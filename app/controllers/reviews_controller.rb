class ReviewsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @review = @post.reviews.create(review_params)
    @review.user_id = current_user.id
    @review.rating *= 10

    @post.rating = @post.rating + (@review.rating - @post.rating) / (@post.reviews.count + 2)
    @post.save

    if @review.save
      redirect_to @post
    else
      render post_path
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @review = Review.find(params[:id])

    @post.rating = @post.rating + (@post.rating - @review.rating) / (@post.reviews.count)
    @post.save

    @review.destroy
    redirect_to post_path(params[:post_id])
  end

  private
    def review_params
      params.permit(:title, :desc, :rating)
    end
end
