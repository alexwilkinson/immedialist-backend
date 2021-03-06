module UpdateItem
  class Show < UpdateItem::Base
    private

    def update_item!
      item.assign_attributes(tmdb_show.attributes)
      update_genres! if tmdb_show.genres.present?
      update_actors! if tmdb_show.actors.present?
      update_show_runners! if tmdb_show.creators.present?
      item.save!
    end

    def tmdb_show
      @tmdb_show ||= Immedialist::TMDB::Show.find(item.tmdb_id)
    end

    def update_genres!
      update_association!(tmdb_show, :tmdb_id, Genre, "show_genres", "genres")
    end

    def update_actors!
      update_association!(tmdb_show, :tmdb_id, ::Creator, "show_actors", "actors")
    end

    def update_show_runners!
      tmdb_show.creators.each do |creator_attributes|
        creator_record = ::Creator.find_by(
          tmdb_id: creator_attributes[:tmdb_id]
        )

        if creator_record
          item.
            show_creators.
            find_or_create_by!(creator: creator_record)
        else
          item.creators << ::Creator.create!(creator_attributes)
        end
      end
    end
  end
end
