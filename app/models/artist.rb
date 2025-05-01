class Artist < ApplicationRecord
    has_many :songs
    validates :name, presence: true, uniqueness: true, format: { without: /\A\s*\z/, message: "can't be blank" }
end
