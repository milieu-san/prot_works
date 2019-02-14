class Prot < ApplicationRecord
  belongs_to :user
  has_many :nodes

  validates :title, presence: true, length: { maximum: 255 }
  validates :content, length: { maximum: 6000 }
  validates :private, inclusion: {in: [true, false]}
  validates :accepts_review, inclusion: {in: [true, false]}
end
