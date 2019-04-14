# frozen_string_literal: true

class User < ApplicationRecord
  has_many :prots, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :giving_stars, foreign_key: 'give_user_id', class_name: 'Star', dependent: :destroy
  has_many :taking_stars, foreign_key: 'take_user_id', class_name: 'Star', dependent: :destroy

  has_many :hearts, dependent: :destroy
  has_many :fav_prots, through: :hearts, source: :prot

  has_many :goods, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :omniauthable

  mount_uploader :icon, ImageUploader

  validates :name, presence: true, length: { maximum: 20 }
  validates :nick_name, presence: true, uniqueness: true, length: { maximum: 30 }, format: { with: /\A[a-z0-9]+\z/i }
  validates :email, presence: true, uniqueness: true

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

     unless user
       user = User.new(
         uid:      auth.uid,
         provider: auth.provider,
         email:    User.dummy_email(auth),
         password: Devise.friendly_token[0, 20],
         icon: auth.info.image,
         name: auth.info.name,
         nick_name: auth.info.nickname,
       )
       user.skip_confirmation!
       user.save
     end
    user
  end

  private

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end
end
