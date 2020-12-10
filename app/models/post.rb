class Post < ApplicationRecord
  belongs_to :user
  has_many :reviews

  validates :title, :desc, presence: true
end
