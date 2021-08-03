
require 'rails_helper'
RSpec.describe UpdateMoviesWorker, type: :worker do
  describe '#perform' do

    subject { described_class.new.perform }
    let(:service) { instance_double('Movies::Update') }
    let(:new_movie) { create(:movie, updated_at: 1.days.ago) }
    let(:old_movie) { create(:movie, updated_at: 4.days.ago) }

    before do
      allow(Movies::Update).to receive(:new).and_return(service)
    end

    context 'when the movie record is less than 2 days old' do
      before do
        new_movie
        allow(service).to receive(:call).and_return(:new_movie)
      end

      it 'calls the update service', aggregate_failures: true do
        expect(Movies::Update).to receive(:new).with(new_movie)
        expect(service).to receive(:call)
        subject
      end
    end

    context 'when the movie record is more than 2 days old' do
      before do
        old_movie
        allow(service).to receive(:call).and_return(old_movie)
      end

      it 'gets deleted', aggregate_failures: true do
        old_movie_id = old_movie.id
        expect{ subject }.to change{ Movie.all.size }.by(-1)
        expect(Movie.exists?(old_movie_id)).to be_falsey
      end
    end
  end
end
