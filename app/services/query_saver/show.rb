class QuerySaver::Show < QuerySaver
  private

  def build_objects
    results.map do |show_result|
      ::Show.new(
        name: show_result.fetch(:name),
        first_air_date: show_result.fetch(:first_air_date),
        tmdb_id: show_result.fetch(:id)
      )
    end
  end
end
