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
  validates :content, length: { maximum: 65535 }
  validates :private, inclusion: {in: [true, false]}
  validates :accepts_review, inclusion: {in: [true, false]}

  before_save :find_or_create_genre
  before_save :find_or_create_media_type

  scope :title_search, ->(search) { where(['title LIKE ?', "%#{search}%"]) if search.present? }
  scope :genre_search, lambda { |genre|
    if genre.present?
      num = []
      point = Genre.find_by(name: genre)
      unless point.nil?
        point.prot_genres.each do |relation|
          num << relation.prot_id
        end
      end
      where(id: num)
    end
  }
  scope :media_type_search, lambda { |media_type|
    if media_type.present?
      number = []
      point_media = MediaType.find_by(name: media_type)
      unless point_media.nil?
        point_media.prot_media_types.each do |relation|
          number << relation.prot_id
        end
      end
      where(id: number)
    end
  }
  scope :user_search, lambda { |nick_name|
    if nick_name.present?
      number_names = []
      point_name = User.find_by(nick_name: nick_name)
      unless point_name.nil?
        point_name.prots.each do |prot|
          number_names << prot.id
        end
      end
      where(id: number_names)
    end
  }
  scope :heart_order, lambda { |heart|
    if heart == 'ハートが多い順'
      includes(:hearts).sort_by { |prot| -prot.hearts.length }
    elsif heart == 'ハートが少ない順'
      includes(:hearts).sort_by { |prot| prot.hearts.length }
    else
      order(created_at: :desc)
    end
  }

  def self.search_order(prot)
     title_search(prot[:title])
    .genre_search(prot[:genre])
    .media_type_search(prot[:media_type])
    .user_search(prot[:nick_name])
    .heart_order(prot[:heart])
  end

  def self.includes_all
     includes(:user)
    .includes(:hearts)
    .includes(:genres)
    .includes(:prot_genres)
    .includes(:media_types)
    .includes(:prot_media_types)
  end

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
