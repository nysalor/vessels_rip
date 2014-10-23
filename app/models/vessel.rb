class Vessel < ActiveRecord::Base

  belongs_to :cause
  belongs_to :classification
  belongs_to :user
  has_many :vessel_revisions

  before_save :split_time

  scope :of_today, ->(datetime) { where(sunk_month: datetime.month, sunk_day: datetime.day) }

  class << self
    def daily_reserve
      self.of_today(Time.zone.now).each do |vessel|
        VesselWorker.perform_in vessel.since_from(Time.zone.now)
      end
    end
  end

  def split_time
    self.attributes = Hash[*sunk_attributes]
  end

  def sunk_attributes
    %w(month day hour min sec).map{ |x|
      ["sunk_#{x}", sunk_at.send(x)]
    }.flatten
  end

  def since_from(datetime)
    Time.zone.local(datetime.year, sunk_month, sunk_day, sunk_hour, sunk_min, sunk_sec) - datetime
  end

  def tweet!
    twitter_connect.client.update tweet_body, tweet_statuses
  end

  def twitter_connect
    @twitter_connect ||= TwitterConnect.new
  end

  def tweet_body
    I18n.t 'messages.vessels.tweet', tweet_params
  end

  def tweet_statuses
    if (latitude.present? && longitude.present?)
      {
        lat: latitude,
        long: longitude,
        display_coordinate: true
      }
    else
      {}
    end
  end

  def tweet_params
    {
      classification: classification.name_ja,
      name_ja: name_ja,
      name_en: name_en,
      sunk_at: I18n.l(sunk_at.to_date, format: :long),
      place: place_name,
      latitude: latitude,
      longitude: longitude,
      cause: cause.description,
      link: map_url
    }
  end

  def coordinates
    [latitude, longitude].join(',')
  end

  def map_url
    "http://maps.google.com/maps?q=#{coordinates}"
  end
end
