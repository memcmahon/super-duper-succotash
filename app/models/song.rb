class Song < ApplicationRecord
  belongs_to :artist
  validates :title, presence: true, format: { without: /\A\s*\z/, message: "can't be blank" }
end
