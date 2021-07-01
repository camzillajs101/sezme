class Reply < ApplicationRecord
  belongs_to :review
  belongs_to :user

  validates :body, presence: true
  validates :body, length: { maximum: 2000 }
end
