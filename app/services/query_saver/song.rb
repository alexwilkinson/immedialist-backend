class QuerySaver::Song < QuerySaver
  private

  def build_objects
    results.map do |song_result|
      album = save_associated_album(song_result)
      artists = save_associated_artists(song_result)

      # NOTE: songs gets artists through albums
      album.artists = artists

      ::Song.new(
        name: song_result.fetch(:name),
        spotify_preview_url: song_result.fetch(:preview_url),
        spotify_id: song_result.fetch(:id),
        album: album
      )
    end
  end

  def save_associated_album(song_result)
    album_results = [song_result.fetch(:album)]
    albums = QuerySaver.const_get("Album", false).call(album_results)
    albums.first
  end

  def save_associated_artists(song_result)
    artist_results = song_result.fetch(:artists)
    QuerySaver.const_get("Artist", false).call(artist_results)
  end
end
