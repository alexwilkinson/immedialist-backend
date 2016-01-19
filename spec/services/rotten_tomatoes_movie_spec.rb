require 'rails_helper'

RSpec.describe RottenTomatoesMovie, type: :service do
  let(:valid_query_result) {
    PatchedOpenStruct.new(
      mpaa_rating: "R",
      critics_consensus: "Brilliant",
      ratings: PatchedOpenStruct.new(
        critics_score: 85,
        audience_score: 70
      )
    )
  }
  let(:invalid_query_result) {
    PatchedOpenStruct.new(
      error: "Could not find a movie with the specified id",
      raw_data: {
        "error" => "Could not find a movie with the specified id"
      }
    )
  }
  let(:imdb_id) { "1234" }
  let(:rotten_tomatoes_movie) { RottenTomatoesMovie.find(imdb_id) }

  describe ".find" do
    context "valid imdb id is passed" do
      it "returns a RottenTomatoesMovie" do
        expect(RottenTomatoes::RottenMovie).
          to receive(:find).
          and_return(valid_query_result)

        expect(rotten_tomatoes_movie).to be_a(RottenTomatoesMovie)
      end
    end

    context "invalid imdb id is passed" do
      it "raises an error" do
        expect(RottenTomatoes::RottenMovie).
          to receive(:find).
          and_return(invalid_query_result)

        expect { rotten_tomatoes_movie }.
          to raise_error(RottenTomatoes::QueryError)
      end
    end

    context "unexpected object type is returned" do
      it "raises an error" do
        expect(RottenTomatoes::RottenMovie).
          to receive(:find).
          and_return({critics_score: 87})

        expect { rotten_tomatoes_movie }.
          to raise_error(TypeError)
      end
    end
  end

  describe "#attributes" do
    it "returns a hash of its attributes" do
      expect(RottenTomatoes::RottenMovie).
        to receive(:find).
        and_return(valid_query_result)

      expect(rotten_tomatoes_movie.attributes).to eq({
        mpaa_rating: "R",
        critics_consensus: "Brilliant",
        critics_score: 85,
        audience_score: 70
      })
    end
  end

  context "attribute methods" do
    before(:each) do
      expect(RottenTomatoes::RottenMovie).
        to receive(:find).
        and_return(valid_query_result)
    end

    describe "#mpaa_rating" do
      it "returns an MPAA Rating" do
        expect(rotten_tomatoes_movie.mpaa_rating).to eq("R")
      end
    end

    describe "#critics_consensus" do
      it "returns the critics' consensus" do
        expect(rotten_tomatoes_movie.critics_consensus).to eq("Brilliant")
      end
    end

    describe "#critics_score" do
      it "returns the critics score" do
        expect(rotten_tomatoes_movie.critics_score).to eq(85)
      end
    end

    describe "#audience_score" do
      it "returns the audience score" do
        expect(rotten_tomatoes_movie.audience_score).to eq(70)
      end
    end
  end
end