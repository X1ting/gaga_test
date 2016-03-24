class Event < ActiveRecord::Base
  has_and_belongs_to_many :games

  validates :name, :start_at, :end_at, :longitude, :latitude, :address, presence: true
  before_validation :set_address

  reverse_geocoded_by :latitude, :longitude

  scope :day_of_start, -> (day:) do
    where('EXTRACT(DOW from start_at) = ?', day.to_i)
  end

  scope :between_time, -> (start_at:, end_at:) do
    where('EXTRACT(HOUR FROM start_at) >= ? AND EXTRACT(HOUR FROM end_at) <= ?', start_at.to_i, end_at.to_i)
  end

  scope :in_distance, -> (distance:, client_longitude:, client_latitude:) do
    near([client_latitude, client_longitude], distance.to_i, :units => :km)
  end

  scope :with_games, -> (game_ids:) do
    Game.includes(:events).where(id: game_ids).map(&:events).reduce(:&)
  end


  def self.filter filter_params ### Its method look like unreadable, it because one smart man say me: "Methods wich do no more than restruct data, may be unreadable, because it work may be understood when you look on result"
    return all if filter_params.nil?
    filter_params.reduce(all) do |result, (key, value)|
      return result if value.blank?
      args = value.reject {|_,v| v.blank?}.to_hash.symbolize_keys!
      (args.count == value.count) && args.present? ? result.public_send(key, args) : result
    end
  end

  private

  def set_address
    founded_address = Geocoder.search([latitude, longitude].join(', '))
    self.address = founded_address.present? ? founded_address.first.address : 'Undefined location'
  end

end
