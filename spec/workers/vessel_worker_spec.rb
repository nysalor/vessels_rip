require 'spec_helper'

describe VesselWorker do
  let(:vessel) { FactoryGirl.create(:vessel, sunk_at: Time.zone.parse('1944-10-25 14:00:00 JST')) }
  let(:current_time) { Time.parse('2014-10-25 00:05:00 JST') }

  before do
    subject.perform vessel.id
  end

  it "performでjobがqueueに入ること" do
    is_expected.to be_processed_in(:tweet)
  end
end
