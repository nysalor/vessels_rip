require 'rails_helper'

RSpec.describe Vessel, :type => :model do
  let!(:vessel) { FactoryGirl.create(:vessel, sunk_at: Time.zone.parse('1944-10-25 14:17:00 JST')) }
  let!(:another_vessel) { FactoryGirl.create(:vessel, sunk_at: Time.zone.parse('1944-04-07 14:23:00 JST')) }
  let(:current_time) { Time.zone.parse('2014-10-25 10:00:00 JST') }
  let(:past_time) { Time.zone.parse('2014-10-01 10:00:00 JST') }

  it "Vesselを作成するとsunk_month,sunk_day,sunk_hour,sunk_min,sunk_secが設定されること" do
    vessel.save
    expect(vessel.sunk_month).to eq(10)
    expect(vessel.sunk_day).to eq(25)
    expect(vessel.sunk_hour).to eq(14)
    expect(vessel.sunk_min).to eq(17)
    expect(vessel.sunk_sec).to eq(0)
  end

  it "of_todayで同じ月日のVesselのみ含まれること" do
    expect(Vessel.of_today(current_time)).to be_include(vessel)
    expect(Vessel.of_today(current_time)).not_to be_include(another_vessel)
  end

  it "since_fromで現在時刻との秒数差が返ること" do
    expect(vessel.since_from(current_time)).to eq(15420)
  end

  it "sunk_at_todayで今日の同時刻を返すこと" do
    Timecop.freeze(current_time)
    expect(vessel.sunk_at_today).to eq(Time.zone.parse('2014-10-25 14:17:00 JST'))
    Timecop.return
  end

  describe "class methods" do
    it "of_todayに同じ月日のvesselが含まれること" do
      expect(Vessel.of_today(current_time)).to be_include(vessel)
    end

    it "of_todayに別の月日のvesselが含まれないこと" do
      expect(Vessel.of_today(current_time)).not_to be_include(another_vessel)
    end

    it "日付が合っている場合、daily_reserveでVesselWorkerがqueueに入ること" do
      Timecop.freeze(current_time)
      Vessel.daily_reserve
      expect(VesselWorker).to be_processed_in(:tweet)
      Timecop.return
    end
  end
end
