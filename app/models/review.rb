class Review < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :title, :desc, presence: true
  validates :rating, numericality: true
  validates :rating, :inclusion => 0..50
  validates :user_id, uniqueness: { scope: :post_id, message: "has already reviewed this post" }
end
