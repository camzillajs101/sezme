class Group < ApplicationRecord
  has_and_belongs_to_many :users
  belongs_to :user

  validates :title, presence: true
end
