class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable

  has_many :posts
  has_many :reviews
  has_many :replies
  has_many :votes, dependent: :destroy
  has_and_belongs_to_many :groups

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable,
         authentication_keys: [:username]

  validates :username, uniqueness: true
  validates :username, presence: true
end
