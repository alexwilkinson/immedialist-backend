class Show < ActiveRecord::Base
  has_many :creators, through: :show_creators # created_by collection from TMDB
  has_many :show_creators
  has_many :directors, through: :show_directors, source: :creator
  has_many :show_directors
  has_many :actors, through: :show_actors, source: :creator
  has_many :show_actors
  has_many :genres, through: :show_genres
  has_many :show_genres
  has_many :list_items, as: :item
end
