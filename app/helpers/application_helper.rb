module ApplicationHelper
  def tab_link(text, url)
    link_to text, url
  end

  include VotesHelper
  def vote_btn(value, model)
    link_to vote_image_for(value, false), votes_path(value: value, voteable_type: model.class.name, voteable_id: model.id), method: :post, remote: true, class: "#{vote_name_for(value)}-btn-container", id: "#{model.class.name.downcase}-#{model.id}-#{vote_name_for(value)}-btn"
  end
  def fake_like_btn # TODO: add dislike btn to fake btns
    link_to image_tag("icons/thumb-up-line.svg", class: "vote-icon"), votes_path, method: :post, remote: false, class: "like-btn-container"
  end
  def unvote_btn(vote)
    link_to vote_image_for(vote.value, true), vote_path(vote), method: :delete, remote: true, class: "unlike-btn reply-un#{vote_name_for(vote.value)}-btn", id: "#{vote.voteable_type.downcase}-#{vote.voteable_id}-un#{vote_name_for(vote.value)}-btn"
  end
end
