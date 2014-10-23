class VesselDailyWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable
  sidekiq_options queue: :daily

  recurrence { daily }

  def perform
    Vessel.daily_reserve
  end
end
