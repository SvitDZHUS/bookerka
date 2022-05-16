# frozen_string_literal: true

class Book < ApplicationRecord
  mount_uploader :cover, CoverUploader
  mount_uploader :book, BookUploader
  has_and_belongs_to_many :categories

  validates :title, presence: true, length: { minimum: 3, maximum: 255 }
  validates :author, presence: true, length: { minimum: 3, maximum: 255 }
  validates :language, presence: true
  validates :cover, presence: true
  validates :categories, presence: true

  def self.latest_books(number)
    order(created_at: :desc).limit(number)
  end
end
