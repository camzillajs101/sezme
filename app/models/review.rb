class Review < ApplicationRecord
  belongs_to :user
  belongs_to :post, inverse_of: :reviews
  has_many :replies

  after_create :update_post
  after_update :update_post
  after_destroy :update_post

  validates :title, :desc, presence: true
  validates :desc, length: { maximum: 2000 }
  validates :rating, numericality: true
  validates :rating, :inclusion => 0..50
  # validates :user_id, uniqueness: { scope: :post_id, message: "has already reviewed this post" }

  def self.sort(post,method)
    case method
    when "new"
      post.reviews.order(created_at: :desc)
    when "old"
      post.reviews.order(created_at: :asc)
    when "rate_high"
      post.reviews.order(rating: :desc)
    when "rate_low"
      post.reviews.order(rating: :asc)
    else
      post.reviews.order(id: :asc)
    end
  end

  private
    def update_post
      post.update_review_average
      post.update_review_count
    end
end
