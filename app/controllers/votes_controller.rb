class VotesController < ApplicationController
  before_action :authenticate_user!

  def create
    @vote = current_user.votes.create(value: params[:value], voteable_type: params[:voteable_type], voteable_id: params[:voteable_id])
    @model = @vote.voteable_type.constantize.find(@vote.voteable_id)
  end

  def destroy
    @vote = Vote.find(params[:id])
    @model = @vote.voteable_type.constantize.find(@vote.voteable_id)
    @vote.destroy
  end
end
