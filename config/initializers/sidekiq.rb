Sidekiq.configure_server do |config|
  config.redis = Settings.sidekiq.redis
end
Sidekiq.configure_client do |config|
  config.redis = Settings.sidekiq.redis
end
