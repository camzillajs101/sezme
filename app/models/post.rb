class Post < ApplicationRecord
  belongs_to :user
  has_many :reviews, inverse_of: :post

  validates :title, :desc, presence: true

  def update_review_average
    update review_average: reviews.average(:rating)
  end
  def update_review_count
    update review_count: reviews.count
  end

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

  def self.sort(method)
    case method
    when "new"
      self.order(created_at: :desc)
    when "popular"
      # sort it by score or something in the future
      self.order(id: :asc)
    when "most_reviews"
      self.order(review_count: :desc)
    when "highest_rating"
      self.order(review_average: :desc)
    when "unrated"
      self.where(review_count: 0)
    else
      self.order(id: :asc)
    end
  end
end
