class Genre < ApplicationRecord
  has_many :prot_genres, dependent: :destroy
  has_many :prots, through: :prot_genres

  validates :name, presence: true, length: { maximum: 16 }
end
