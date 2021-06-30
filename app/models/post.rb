class Post < ApplicationRecord
  belongs_to :user
  has_many :reviews

  validates :title, :desc, presence: true

  def self.rating(id)
    reviews = Post.find(id).reviews
    count = [reviews.count, 1].max
    sum = 0

    reviews.each do |review|
      sum += review.rating
    end

    return sum / count / 10.0
  end

  def self.readablerating(id)
    rating = Post.rating(id)

    if rating < 1
      return "[unrated]"
    else
      return "#{rating} stars"
    end
  end

  def self.stats(id,rating)
    reviews = Post.find(id).reviews
    total = [reviews.count, 1].max
    count = 0

    reviews.each do |review|
      if review.rating == rating * 10
        count += 1
      end
    end

    return (count / total.to_f * 100).to_i
  end
end
