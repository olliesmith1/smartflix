
require 'rails_helper'
RSpec.describe CreateMovieWorker, type: :worker do
  describe '#perform' do

    let(:service) { instance_double('Movies::Create') }

    before do
      allow(Movies::Create).to receive(:new).and_return(service)
    end

    it 'calls the create service', aggregate_failures: true do
      expect(Movies::Create).to receive(:new).with('Cars')
      expect(service).to receive(:call)
      CreateMovieWorker.new.perform('Cars')
    end
  end
end
