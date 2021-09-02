module VotesHelper
  def vote_name_for(value)
    case value
    when 0
      "like"
    when 1
      "dislike"
    end
  end
  def vote_image_for(value,unvote)
    type = unvote ? "fill" : "line"
    case value
    when 0
      image_tag("icons/thumb-up-#{type}.svg", class: "vote-icon")
    when 1
      image_tag("icons/thumb-down-#{type}.svg", class: "vote-icon")
    end
  end
end
