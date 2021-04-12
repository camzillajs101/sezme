class Post < ApplicationRecord
  belongs_to :user
  has_many :reviews

  validates :title, :desc, presence: true

  acts_as_taggable_on :tags

  def self.calcrating(post)
    rating = Post.find(post.id).rating
    if rating < 0
      return "unrated"
    else
      return "#{rating.to_f / 10} stars"
    end
  end
end
