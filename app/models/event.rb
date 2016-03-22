class Event < ActiveRecord::Base
  has_and_belongs_to_many :games

  validates :name, :start_at, :end_at, :longitude, :latitude, :address, presence: true
  before_validation :set_address

  reverse_geocoded_by :latitude, :longitude

  def set_address
    founded_address = Geocoder.search([latitude, longitude].join(', '))
    address = founded_address.present? ? founded_address.first.address : 'Undefined location'
  end
end
