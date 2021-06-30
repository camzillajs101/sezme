class RepliesController < ApplicationController
  def new
    @review = Review.find(params[:review_id])
    @reply = @review.replies.new
  end

  def create
    @review = Review.find(params[:review_id])
    @reply = @review.replies.new(reply_params)

    if @reply.save
      redirect_to @review
    else
      render :new
    end
  end

  protected
    def reply_params
      params.require(:reply).permit(:body).merge(user_id: current_user.id)
    end
end
