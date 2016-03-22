class Event < ActiveRecord::Base
  has_and_belongs_to_many :games

  validates :name, :start_at, :end_at, :longitude, :latitude, :address, presence: true
  before_validation :set_address

  reverse_geocoded_by :latitude, :longitude

  scope :day_of_start, -> (day_number:) do
    where('EXTRACT(DOW from start_at) = ?', day_number.to_i)
  end

  scope :between_time, -> (start_at:, end_at:) do
    where('EXTRACT(HOUR FROM start_at) >= ? AND EXTRACT(HOUR FROM end_at) <= ?', start_at.to_i, end_at.to_i)
  end

  scope :with_games, -> (game_ids:) do
    distinct.joins(:games).merge(
      Game.includes(:events).where(id: game_ids).map(&:events).reduce(:&))
  end


  def self.filter filter_params
    filter_params.reduce(all) do |result, (key, value)|
      result.send(key, value) if value.present?
    end
  end

  private

  def set_address
    founded_address = Geocoder.search([latitude, longitude].join(', '))
    self.address = founded_address.present? ? founded_address.first.address : 'Undefined location'
  end

end
