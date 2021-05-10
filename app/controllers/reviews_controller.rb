class ReviewsController < ApplicationController
  def show
    render 'posts/show'
  end

  def create
    @post = Post.find(params[:post_id])
    @review = @post.reviews.new(review_params)

    @post.rating = @post.rating > 0 ? @post.rating + (@review.rating - @post.rating) / (@post.reviews.count + 1) : @review.rating
    @post.save

    if @review.save
      redirect_to @post
    else
      @review.errors.full_messages.each do |e|
        puts e
      end
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
      params.require(:review).permit(:title, :desc, :rating).merge(user_id: current_user.id)
    end
end
