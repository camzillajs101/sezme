class Review < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :title, :desc, presence: true
  validates :rating, numericality: true
  validates :rating, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 50 }
  validates :user_id, uniqueness: { scope: :post_id }
end
