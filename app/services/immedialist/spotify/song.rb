module Immedialist
  module Spotify
    class Song < SpotifyResource
      RSPOTIFY_CLASS = RSpotify::Track

      def self.search(song_name)
        super(song_name, RSPOTIFY_CLASS)
      end

      def artists
        query_result[:artists].map do |artist_attributes|
          Immedialist::Spotify::Artist.new(artist_attributes)
        end
      end

      def album
        Immedialist::Spotify::Album.new(query_result[:album])
      end

      def spotify_preview_url
        query_result[:preview_url]
      end

      private

      def rspotify_class
        RSPOTIFY_CLASS
      end

      def active_attributes
        [
          :duration_ms,
          :name,
          :spotify_preview_url,
          :spotify_url,
          :spotify_id,
          :disc_number,
          :track_number,
          :spotify_popularity
        ]
      end
    end
  end
end
