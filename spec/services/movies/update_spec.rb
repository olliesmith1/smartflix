

require 'rails_helper'

RSpec::Matchers.define_negated_matcher :not_change, :change

RSpec.describe Movies::Update do
  describe '#call' do

    let(:api_call) { instance_double('Apis::Omdb') }
    let(:movie) { build(:movie) }
    let(:identical_movie_data) { { "Title"=>"Cars", "imdbVotes"=>"380,993", "Response"=>"True" } }
    let(:updated_movie_data) { { "Title"=>"Cars", "imdbVotes"=>"400,678", "Response"=>"True" } }

    before do
      allow(Apis::Omdb).to receive(:new).and_return(api_call)
    end

    context 'when the movie is identical to the refreshed version' do
      before do
        allow(api_call).to receive(:call).and_return(identical_movie_data)
      end

      it 'touches the movie' do
        expect{ Movies::Update.new(movie).call }.to change{ movie.updated_at }
                                                    .and(not_change { movie.imdb_votes })
      end
    end

    context 'when the movie is not identical to the refreshed version' do
      before do
        allow(api_call).to receive(:call).and_return(updated_movie_data)
      end

      it 'replaces the movie with the updated version' do
        expect{ Movies::Update.new(movie).call }.to change{ movie.updated_at }
                                                      .and(change { movie.imdb_votes })
      end
    end
  end
end
