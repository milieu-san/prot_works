class User < ApplicationRecord
  has_many :prots, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :giving_stars, foreign_key: 'give_user_id', class_name: 'Star', dependent: :destroy
  has_many :taking_stars, foreign_key: 'take_user_id', class_name: 'Star', dependent: :destroy

  has_many :give_stars, through: :giving_stars, source: :giving
  has_many :has_stars, through: :taking_stars, source: :taking

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  mount_uploader :icon, ImageUploader

  validates :name, presence: true, length: { maximum: 20 }
  validates :nick_name, presence: true, uniqueness: true, length: { maximum: 30 }, format: { with: /\A[a-z0-9]+\z/i }
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
end
