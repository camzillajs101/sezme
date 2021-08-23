class Reply < ApplicationRecord
  belongs_to :review
  belongs_to :user
  has_many :votes, as: :voteable, dependent: :destroy

  validates :body, presence: true
  validates :body, length: { maximum: 2000 }
end
