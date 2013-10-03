class Visit < ActiveRecord::Base
  attr_accessible :visitor_id, :short_url_id

  def self.record_visit!(user, shortened_url)
    Visit.new(visitor_id: user.id, short_url_id: shortened_url.id)
  end

  #belong to shortened_url
  #also to visitor
  belongs_to(
    :shortened_url,
    class_name: "ShortenedUrl",
    foreign_key: :short_url_id,
    primary_key: :id
  )

  belongs_to(
    :visitor,
    class_name: "User",
    foreign_key: :visitor_id,
    primary_key: :id
  )

end
