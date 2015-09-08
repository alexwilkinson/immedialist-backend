class Search::ArtistSerializer < SearchSerializer
  has_many :creators

  def creators
    Array(object.results)
  end
end
