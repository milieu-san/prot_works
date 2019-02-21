class Prot < ApplicationRecord
  belongs_to :user
  has_many :nodes, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :hearts

  validates :title, presence: true, length: { maximum: 255 }
  validates :private, inclusion: {in: [true, false]}
  validates :accepts_review, inclusion: {in: [true, false]}
end
