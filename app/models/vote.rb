class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :voteable, polymorphic: true

  validates :user_id, uniqueness: { scope: [:voteable_id, :voteable_type] }
  validates :value, inclusion: 0..1
end
