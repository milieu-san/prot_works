# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :review
  belongs_to :user

  validates :body, presence: true
end
