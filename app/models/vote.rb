class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :voteable, polymorphic: true

  after_create :update_review
  after_destroy :update_review

  validates :user_id, uniqueness: { scope: [:voteable_id, :voteable_type, :value] }
  validates :value, inclusion: 0..3

  private
    def update_review
      if voteable_type == "Review"
        voteable.update_ci_lower_bound
      end
    end
end
