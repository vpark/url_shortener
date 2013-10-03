class ShortenedUrl < ActiveRecord::Base
  attr_accessible :short_url, :long_url, :submitter_id
  #validates :long_url, :unique => true, :presence => true

  def self.random_code
    short_url = SecureRandom.urlsafe_base64[0...2]
    until self.find_by_short_url(short_url).nil?
      short_url = SecureRandom.urlsafe_base64[0...2]
    end
    short_url
  end

  def self.create_for_user_and_long_url!(user, long_url)
    ShortenedUrl.new(short_url: self.random_code, submitter_id: user.id, long_url: long_url)
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    visits.count(:visitor_id, distinct: true)
  end

  def num_recent_uniques
    t = (Time.now - 600..Time.now) #ten minutes ago

    visits.where(created_at: t).count(:visitor_id, distinct: true)
  end

  belongs_to(
    :submitter,
    class_name: "User",
    foreign_key: :submitter_id,
    primary_key: :id
  )

  # has_many visitors
  has_many(
    :visits,
    class_name: "Visit",
    foreign_key: :short_url_id,
    primary_key: :id
  )

  has_many :visitors, :through => :visits, :source => :user, :uniq => true
end

