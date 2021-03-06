class Book < ActiveRecord::Base
  has_many :book_authors
  has_many :authors, through: :book_authors, source: :creator
  has_many :book_genres
  has_many :genres, through: :book_genres
  has_many :list_items, as: :item
end
