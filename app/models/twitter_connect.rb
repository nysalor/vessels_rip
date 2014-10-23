class TwitterConnect
  include ActiveModel::Model

  def initialize(opts = {})
    @config = default_config.merge opts
  end

  def client
    @client ||= Twitter::REST::Client.new do |c|
      c.consumer_key = @config[:consumer_key]
      c.consumer_secret = @config[:consumer_secret]
      c.access_token = @config[:access_token]
      c.access_token_secret= @config[:access_token_secret]
    end
  end

  def default_config
    {
      consumer_key: config["consumer_key"],
      consumer_secret: config["consumer_secret"],
      access_token: config["access_token"],
      access_token_secret: config["access_secret"]
    }
  end

  def config
    Rails.application.secrets.twitter
  end
end
