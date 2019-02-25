# frozen_string_literal: true

class Good < ApplicationRecord
  belongs_to :user
  belongs_to :review

  validates :user_id, presence: true, uniqueness: { scope: :review_id }
end
