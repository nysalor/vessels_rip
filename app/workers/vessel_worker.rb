class VesselWorker
  include Sidekiq::Worker
  sidekiq_options queue: :tweet

  def perform(id)
    @vessel = Vessel.find id
    @vessel.tweet!
    logger.info "Vessel #{id} tweeted."
  end
end
