class Filter < ActiveRecord::Base
  FIELDS_FOR_DIGEST = [:start_time, :end_time, :distance, :day_of_start]
  has_and_belongs_to_many :games
  validates :digest, uniqueness: true
  before_validation :add_digest
  enum day_of_start: %i(Sunday Monday Tuesday Wednesday Thursday Friday Saturday)

  def day_of_start_int
    Filter.day_of_starts[self.day_of_start]
  end

  def add_digest
    digest = {}
    md5 = Digest::MD5.new
    FIELDS_FOR_DIGEST.each {|field| digest[field] = self.send(field)}
    self.digest = (md5.update digest.to_s).to_s
  end
end
