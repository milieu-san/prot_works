class User < ApplicationRecord
  has_many :prots
  has_many :reviews
  has_many :comments
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable


  validates :name, presence: true, length: { maximum: 20 }
  validates :nick_name, presence: true, uniqueness: true, length: { maximum: 30 }, format: { with: /\A[a-z0-9]+\z/i }
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
end
