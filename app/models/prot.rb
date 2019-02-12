class Prot < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :content, length: { maximum: 6000 }
  validates :private, inclusion: {in: [true, false]}
  validates :private, inclusion: {in: [true, false]}
end
