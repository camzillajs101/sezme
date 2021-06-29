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
end
