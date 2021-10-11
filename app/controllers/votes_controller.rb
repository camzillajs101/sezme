class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    @vote = current_user.votes.create(value: params[:value], voteable_type: params[:voteable_type], voteable_id: params[:voteable_id])
    if params[:value].to_i <= 1
      @inverse_vote = Vote.find_by(user_id: current_user.id, voteable_type: params[:voteable_type], voteable_id: params[:voteable_id], value: 1-params[:value].to_i)
      @inverse_vote.destroy if @inverse_vote != nil
    end
    @model = @vote.voteable
  end

  def destroy
    @vote = Vote.find(params[:id])
    @model = @vote.voteable
    @vote.destroy
  end
end
