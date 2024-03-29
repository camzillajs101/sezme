class Post < ApplicationRecord
  belongs_to :user
  has_many :reviews, inverse_of: :post
  has_many :votes, as: :voteable, dependent: :destroy

  acts_as_punchable
  # acts_as_taggable_on :tags

  validates :title, :desc, presence: true

  def update_review_average
    update review_average: reviews.average(:rating)
  end
  def update_review_count
    update review_count: reviews.count
  end
  def update_bayesian
    update bayesian: bayesian
  end

  def rating
    count = [reviews.count, 1].max
    sum = 0

    reviews.each do |review|
      sum += review.rating
    end

    return sum / count / 10.0
  end

  def readablerating
    if review_count == 0
      return "[unrated]"
    else
      return "#{rating} stars"
    end
  end

  def stats(num_rating)
    total = [reviews.count, 1].max
    count = 0

    reviews.each do |review|
      if review.rating == num_rating * 10
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
      self.most_hit
    when "most_reviews"
      self.order(review_count: :desc)
    when "top"
      self.order(bayesian: :desc)
    when "unrated"
      self.where(review_count: 0)
    else
      self.order(created_at: :desc)
    end
  end

  def bayesian
    # constants
    capitalK = 5
    s = [1,2,3,4,5]
    z = 1.65
    reviews = self.reviews
    capitalN = reviews.count
    n = [0,0,0,0,0]
    s.each do |r|
      n[r-1] = reviews.where(rating: r*10).count
    end

    firstpart = 0.0
    for k in 1..capitalK
      firstpart += s[k-1] * ((n[k-1]+1)/(capitalN+capitalK).to_f)
    end

    sum_a = 0.0
    for k_2 in 1..capitalK
      sum_a += (s[k_2-1] ** 2) * ((n[k_2-1]+1)/(capitalN+capitalK).to_f)
    end
    sum_b = 0.0
    for k_3 in 1..capitalK
      sum_b += s[k_3-1] * ((n[k_3-1]+1)/(capitalN+capitalK).to_f)
    end
    sum_b = sum_b ** 2
    secondpart = -z * Math.sqrt((sum_a-sum_b)/(capitalN+capitalK+1).to_f)

    return firstpart + secondpart
  end
end
