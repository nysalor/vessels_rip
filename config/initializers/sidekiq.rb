Sidekiq.configure_server do |config|
  config.redis = { url: Settings.sidekiq.redis.url, namespace: Settings.sidekiq.redis.namespace }
end
Sidekiq.configure_client do |config|
  config.redis = { url: Settings.sidekiq.redis.url, namespace: Settings.sidekiq.redis.namespace }
end
