class Prot < ApplicationRecord
  belongs_to :user
  has_many :nodes, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :hearts, dependent: :destroy

  has_many :prot_genres, dependent: :destroy
  has_many :genres, through: :prot_genres

  has_many :prot_media_types, dependent: :destroy
  has_many :media_types, through: :prot_media_types

  accepts_nested_attributes_for :genres, allow_destroy: true, reject_if: proc { |attributes| attributes['name'].blank? }
  accepts_nested_attributes_for :media_types, allow_destroy: true, reject_if: proc { |attributes| attributes['name'].blank? }

  validates :title, presence: true, length: { maximum: 255 }
  validates :private, inclusion: {in: [true, false]}
  validates :accepts_review, inclusion: {in: [true, false]}

  before_save :find_or_create_genre

  private

  def find_or_create_genre
    self.genres = self.genres.map do |genre|
      Genre.find_or_create_by(name: genre.name)
    end
  end

  def find_or_create_media_type
    self.media_types = self.media_types.map do |genre|
      MediaType.find_or_create_by(name: genre.name)
    end
  end
end
