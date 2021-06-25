class ReviewsController < ApplicationController
  def show
    @showreview = Review.find(params[:id])
    @post = Post.find(@showreview.post_id)
    @user = User.find(@post.user_id)
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

  def edit
    @review = Review.find(params[:id])
    @post = Post.find(@review.post_id)
    @user = User.find(@post.user_id)

    if @review.user_id != current_user.id
      redirect_to post_review_path(@post, @review)
    end
  end

  def update
    @review = Review.find(params[:id])
    @post = Post.find(@review.post_id)

    @oldrating = @review.rating
    @newrating = review_params[:rating].to_i

    if @review.update(review_params)
      if @post.reviews.count > 1
        # puts "\n\n\n\n after removal:"
        # puts "rating = #{@post.rating} + (#{@post.rating} - #{@oldrating}) / (#{@post.reviews.count} - 1) ="
        @post.rating = @post.rating + (@post.rating - @oldrating) / (@post.reviews.count - 1) # removes current rating
        # puts @post.rating

        # puts "\n\n\n\n after re-addition:"
        # puts "rating = #{@post.rating} + (#{@newrating} - #{@post.rating}) / #{@post.reviews.count} ="
        @post.rating = @post.rating + (@newrating - @post.rating) / (@post.reviews.count) # re-calculates with new rating
        # puts @post.rating
      else # if this is the only review, just set the post's rating to the new rating
        @post.rating = @newrating
      end
      @post.save

      redirect_to post_review_path(@post, @review)
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @review = Review.find(params[:id])

    @post.rating = @post.reviews.count > 1 ? @post.rating + (@post.rating - @review.rating) / (@post.reviews.count - 1) : -1
    @post.save

    @review.destroy
    redirect_to post_path(params[:post_id])
  end

  private
    def review_params
      params.require(:review).permit(:title, :desc, :rating).merge(user_id: current_user.id)
    end
end
