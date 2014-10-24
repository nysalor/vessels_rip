require 'spec_helper'

describe 'VesselsController' do
  describe 'routing' do
    it 'routes to #index' do
      expect({ get: '/vessels' }).to route_to('vessels#index')
    end

    it 'routes to #show' do
      expect({ get: '/vessels/1' }).to route_to('vessels#show', id: "1")
    end

    it 'routes to #new' do
      expect({ get: '/vessels/new' }).to route_to('vessels#new')
    end

    it 'routes to #edit' do
      expect({ get: '/vessels/1/edit' }).to route_to('vessels#edit', id: "1")
    end
  end
end

describe 'VesselRevisionsController' do
  describe 'routing' do
    it 'routes to #create' do
      expect({ post: '/vessel_revisions' }).to route_to('vessel_revisions#create')
    end
  end
end
