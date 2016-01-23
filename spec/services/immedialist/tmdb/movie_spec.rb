require 'rails_helper'

RSpec.describe Immedialist::TMDB::Movie, type: :service do
  let(:valid_query_result) {
    {"adult"=>false,
     "backdrop_path"=>"/7u3pxc0K1wx32IleAkLv78MKgrw.jpg",
     "belongs_to_collection"=> {
       "id"=>2344,
       "name"=>"The Matrix Collection",
       "poster_path"=>"/lh4aGpd3U9rm9B8Oqr6CUgQLtZL.jpg",
       "backdrop_path"=>"/bRm2DEgUiYciDw3myHuYFInD7la.jpg"
     },
     "budget"=>63000000,
     "genres"=>[
       {"id"=>12, "name"=>"Adventure"},
       {"id"=>28, "name"=>"Action"},
       {"id"=>53, "name"=>"Thriller"},
       {"id"=>878, "name"=>"Science Fiction"}
     ],
     "homepage"=>"http://homepage.com",
     "id"=>603,
     "imdb_id"=>"tt0133093",
     "original_language"=>"en",
     "original_title"=>"The Matrix",
     "overview"=> "lots of overview words",
     "popularity"=>6.62633,
     "poster_path"=>"/lZpWprJqbIFpEV5uoHfoK0KCnTW.jpg",
     "production_companies"=>[
       {"name"=>"Village Roadshow Pictures", "id"=>79},
       {"name"=>"Groucho II Film Partnership", "id"=>372},
       {"name"=>"Silver Pictures", "id"=>1885},
       {"name"=>"Warner Bros.", "id"=>6194}
     ],
     "production_countries"=>[
       {"iso_3166_1"=>"AU", "name"=>"Australia"},
        {"iso_3166_1"=>"US", "name"=>"United States of America"}
     ],
     "release_date"=>"1999-03-30",
     "revenue"=>463517383,
     "runtime"=>136,
     "spoken_languages"=>[
       {"iso_639_1"=>"en", "name"=>"English"}
     ],
     "status"=>"Released",
     "tagline"=>"Welcome to the Real World.",
     "title"=>"The Matrix",
     "video"=>false,
     "vote_average"=>7.6,
     "vote_count"=>4866}
  }
  let(:invalid_query_result) {
    {
      "status_code" => 34,
      "status_message" => "The resource you requested could not be found."
    }
  }
  let(:stub_tmdb_api_with_valid_query) {
    expect(Tmdb::Movie).
    to receive(:detail).
    with(tmdb_id).
    and_return(valid_query_result)
  }
  let(:tmdb_id) { "1234" }
  let(:tmdb_movie) { Immedialist::TMDB::Movie.find(tmdb_id) }

  describe ".find" do
    context "valid tmdb id is passed" do
      it "returns a Immedialist::TMDB::Movie" do
        stub_tmdb_api_with_valid_query

        expect(tmdb_movie).to be_a(Immedialist::TMDB::Movie)
      end
    end

    context "invalid imdb id is passed" do
      context "does not match on TMDB" do
        it "raises a TMDB::QueryError" do
          expect(Tmdb::Movie).
            to receive(:detail).
            with(tmdb_id).
            and_return(invalid_query_result)

          expect { tmdb_movie }.
            to raise_error(Immedialist::TMDB::QueryError)
        end
      end
    end

    context "unexpected object type is returned" do
      it "raises an error" do
        expect(Tmdb::Movie).
          to receive(:detail).
          with(tmdb_id).
          and_return([[:budget, 900000]])

        expect { tmdb_movie }.to raise_error(TypeError)
      end
    end
  end

  describe "#attributes" do
    it "returns a hash of its attributes" do
      stub_tmdb_api_with_valid_query

      expect(tmdb_movie.attributes.keys).
        to eq(Immedialist::TMDB::Movie::ACTIVE_ATTRIBUTES)
    end
  end

  context "attribute methods" do
    before(:each) do
      stub_tmdb_api_with_valid_query
    end

    describe "#budget" do
      it "returns the movie's budget" do
        expect(tmdb_movie.budget).to eq(63000000)
      end
    end
  end
end
