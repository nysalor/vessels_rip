require 'spec_helper'

describe VesselDailyWorker do
  let(:vessels) { 3.times.map{ |x|
      FactoryGirl.create(:vessel, sunk_at: Time.zone.parse('1944-10-25 10:00:00 JST').since(x.hour))
    } }
  let(:another_vessel) { FactoryGirl.create(:vessel, sunk_at: Time.zone.parse('1944-10-26 12:00:00 JST')) }

  before do
    subject.perform
  end

  it "performでjobがqueueに入ること" do
    is_expected.to be_processed_in(:daily)
  end
end
