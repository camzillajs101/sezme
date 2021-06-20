class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable

  has_many :posts, dependent: :destroy
  has_many :reviews

  validates :username, uniqueness: true
  validates :username, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable,
         authentication_keys: [:username]

  serialize :settings
end
