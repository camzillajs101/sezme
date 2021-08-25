module ApplicationHelper
  def tab_link(text, url)
    link_to text, url
  end

  def like_btn(value, model)
    link_to image_tag("icons/thumb-up-line.svg", class: "vote-icon"), votes_path(value: value, voteable_type: model.class.name, voteable_id: model.id), method: :post, remote: true, class: "like-btn-container", id: "#{model.class.name.downcase}-#{model.id}-like-btn"
  end
  def fake_like_btn
    link_to image_tag("icons/thumb-up-line.svg", class: "vote-icon"), votes_path, method: :post, remote: false, class: "like-btn-container"
  end
  def unlike_btn(vote)
    link_to image_tag("icons/thumb-up-fill.svg", class: "vote-icon"), vote_path(vote), method: :delete, remote: true, class: "unlike-btn reply-unlike-btn", id: "#{vote.voteable_type.downcase}-#{vote.voteable_id}-unlike-btn"
  end
end
