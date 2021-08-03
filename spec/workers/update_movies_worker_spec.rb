#
# require 'rails_helper'
# RSpec.describe UpdateMoviesWorker, type: :worker do
#   describe '#perform' do
#
#     let(:service) { instance_double('Movies::Update') }
#     let(:old_movie) { create(:movie, updated_at: 3.days.ago) }
#
#     before do
#       allow(Movies::Update).to receive(:new).and_return(service)
#     end
#
#     # context 'when the movie record is less than 2 days old' do
#     #   before do
#     #     allow(service).to receive(:call).and_return(service)
#     #   end
#     #
#     #   it 'calls the update service', aggregate_failures: true do
#     #     expect(Movies::Update).to receive(:new).with('Cars')
#     #     expect(service).to receive(:call)
#     #     UpdateMoviesWorker.new.perform
#     #   end
#     # end
#
#     context 'when the movie record is more than 2 days old' do
#       before do
#         old_movie
#         allow(service).to receive(:call).and_return(old_movie)
#       end
#
#       it 'gets deleted', aggregate_failures: true do
#         old_movie_id = old_movie.id
#         old_movie.destroy
#         expect{ UpdateMoviesWorker.new.perform }.to change{ Movie.all.size }.by(-1)
#         expect(Movie.exists?(old_movie_id)).to be_falsey
#       end
#     end
#   end
# end
