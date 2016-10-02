class Photo < ApplicationRecord
  before_save :geocode_location

  def geocode_location
    if self.location.present?
      url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{URI.encode(self.location)}"

      raw_data = open(url).read

      parsed_data = JSON.parse(raw_data)

      if parsed_data["results"].present?
        self.location_latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]

        self.location_longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

        self.location_formatted_address = parsed_data["results"][0]["formatted_address"]
      end
    end
  end
  # Direct associations

  has_many   :comments,
             :dependent => :destroy

  has_many   :likes,
             :class_name => "Vote",
             :dependent => :destroy

  belongs_to :owner,
             :class_name => "User",
             :counter_cache => :posted_photos_count

  # Indirect associations

  has_many   :commenters,
             :through => :comments,
             :source => :commenter

  has_many   :followers,
             :through => :owner,
             :source => :followers

  has_many   :fans,
             :through => :likes,
             :source => :user

  # Validations

  validates :image, :presence => true

  validates :owner_id, :presence => true

end
