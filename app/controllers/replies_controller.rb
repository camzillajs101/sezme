class RepliesController < ApplicationController
  def index
    @review = Review.find(params[:review_id])
    @replies = @review.replies.order(created_at: :asc)
  end

  def new
    @review = Review.find(params[:review_id])
    @reply = @review.replies.new
  end

  def create
    @review = Review.find(params[:review_id])
    @reply = @review.replies.new(reply_params)

    if @reply.save
      redirect_to_post
    else
      render :new
    end
  end

  def edit
    @reply = Reply.find(params[:id])
  end

  def update
    @reply = Reply.find(params[:id])

    if @reply.update(reply_params)
      redirect_to_post
    else
      render :edit
    end
  end

  def destroy
    @reply = Reply.find(params[:id])
    @reply.destroy
    redirect_to_post
  end

  protected
    def reply_params
      params.require(:reply).permit(:body).merge(user_id: current_user.id)
    end
    def redirect_to_post
      redirect_to post_path(Post.find(Review.find(@reply.review_id).post_id)) + "#reply-#{@reply.id}"
    end
end
