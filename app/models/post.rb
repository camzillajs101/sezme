class Post < ApplicationRecord
  belongs_to :user
  has_many :reviews

  validates :title, :desc, presence: true

  acts_as_taggable_on :tags
end
