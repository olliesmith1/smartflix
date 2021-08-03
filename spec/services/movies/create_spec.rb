
require 'rails_helper'

RSpec::Matchers.define_negated_matcher :not_change, :change

RSpec.describe Movies::Create do
  describe '#call' do

    let(:api_call) { instance_double('Apis::Omdb') }
    let(:good_movie_data) { { "Title"=>"Cars", "Response"=>"True"} }
    let(:not_movie_data) { {"Response"=>"False", "Error"=>"Movie not found!"} }

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
