
require 'rails_helper'

RSpec::Matchers.define_negated_matcher :not_change, :change

RSpec.describe Movies::Create do
  describe '#call' do

    let(:api_call) { instance_double('Apis::Omdb') }
    let(:good_movie_data) { { "Title"=>"Cars", "Year"=>"2006", "Rated"=>"G", "Released"=>"09 Jun 2006", "Runtime"=>"117 min", "Genre"=>"Animation, Comedy, Family", "Director"=>"John Lasseter, Joe Ranft", "Writer"=>"John Lasseter, Joe Ranft, Jorgen Klubien", "Actors"=>"Owen Wilson, Bonnie Hunt, Paul Newman", "Plot"=>"", "Language"=>"English, Italian, Japanese, Yiddish", "Country"=>"United States", "Awards"=>"2 Oscars", "Poster"=>"", "Ratings"=>[{"Source"=>"Internet Movie Database", "Value"=>"7.1/10"}, {"Source"=>"Rotten Tomatoes", "Value"=>"74%"}, {"Source"=>"Metacritic", "Value"=>"73/100"}], "Metascore"=>"73", "imdbRating"=>"7.1", "imdbVotes"=>"380,993", "imdbID"=>"tt0317219", "Type"=>"movie", "DVD"=>"01 Feb 2016", "BoxOffice"=>"$244,082,982", "Production"=>"Disney Pictures", "Website"=>"N/A", "Response"=>"True", "Timestamp"=>"2021-08-02 12:03:13.004339 +0100" } }
    let(:not_movie_data) { {"Response"=>"False", "Error"=>"Movie not found!", "Timestamp"=>"2021-08-02 12:05:19.106089 +0100"} }

    before do
      allow(Apis::Omdb).to receive(:new).and_return(api_call)
    end

    context 'when a real movie name is provided' do
      before do
        allow(api_call).to receive(:call).and_return(good_movie_data)
      end

      it 'saves a movie' do
        expect{ Movies::Create.new('Cars').call }.to change{ Movie.all.size }.by(1)
      end
    end

    context 'when a not movie name is provided' do
      before do
        allow(api_call).to receive(:call).and_return(not_movie_data)
      end

      it 'does not save the movie if not a real movie' do
        expect{ Movies::Create.new('notmovie').call }.to not_change{ Movie.all.size }
      end
    end
  end
end
