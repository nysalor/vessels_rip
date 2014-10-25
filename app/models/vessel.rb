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
        if vessel.sunk_at_today > Time.zone.now
          VesselWorker.perform_at vessel.sunk_at_today, vessel.id
        end
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
    sunk_at_today - datetime
  end

  def sunk_at_today
    Time.local Time.zone.now.year, sunk_month, sunk_day, sunk_hour, sunk_min, sunk_sec
  end

  def tweet!
    twitter_connect.client.update tweet_body, tweet_statuses
  end

  def twitter_connect
    @twitter_connect ||= TwitterConnect.new
  end

  def tweet_body
    if has_location?
      I18n.t 'messages.vessels.tweet.long', tweet_params
    else
      I18n.t 'messages.vessels.tweet.short', tweet_params
    end
  end

  def tweet_statuses
    if has_location?
      {
        lat: latitude,
        long: longitude,
        display_coordinates: true
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

  def has_location?
    latitude.present? && longitude.present?
  end
end
