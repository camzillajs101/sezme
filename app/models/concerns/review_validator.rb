class ReviewValidator < ActiveModel::Validator
  def validate(record)
    if Review.where(user_id: record.user_id).where(post_id: record.post_id) >= 1
      record.errors.add(:rating, "You've already reviewed this post.")
    end
  end
end
