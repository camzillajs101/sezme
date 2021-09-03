class Review < ApplicationRecord
  belongs_to :user
  belongs_to :post, inverse_of: :reviews
  has_many :replies
  has_many :votes, as: :voteable, dependent: :destroy

  after_create :update_post
  after_update :update_post
  after_destroy :update_post

  validates :title, :desc, :rating, presence: true
  validates :desc, length: { maximum: 2000 }
  validates :rating, numericality: true
  validates :rating, :inclusion => 0..50
  validates :user_id, uniqueness: { scope: :post_id, message: "has already reviewed this post" }

  def update_ci_lower_bound
    update ci_lower_bound: ci_lower_bound
  end

  def self.sort(post,method)
    case method
    when "best"
      post.reviews.order(ci_lower_bound: :desc)
    when "new"
      post.reviews.order(created_at: :desc)
    when "rate_high"
      post.reviews.order(rating: :desc)
    when "rate_low"
      post.reviews.order(rating: :asc)
    else
      post.reviews.order(ci_lower_bound: :desc)
    end
  end

  def ci_lower_bound
    positive = self.votes.where(value: 0).count
    negative = self.votes.where(value: 1).count
    total = positive + negative.to_f
    return 0.0 if total == 0.0
    sign = 1
    if positive == 0
      positive = negative
      negative = 0
      sign = -1
    end
    ratio = positive / total
    z = 1.96

    return sign*(ratio+(z**2/(2*total)-z*Math.sqrt((ratio*(1-ratio)+(z**2/(4*total)))/total)))/(1+(z**2/total)) # awful
  end

  private
    def update_post
      post.update_review_average
      post.update_review_count
      post.update_bayesian
    end
end
