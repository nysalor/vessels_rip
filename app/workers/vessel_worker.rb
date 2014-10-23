class VesselWorker
  include Sidekiq::Worker
  sidekiq_options queue: :tweet

  def perform(id)
    @vessel = Vessel.find id
    @vessel.tweet!
  end
end
