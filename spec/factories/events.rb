FactoryGirl.define do
  factory :event do
    name 'GameName'
    start_at DateTime.new(2016, 01, 01, 12) #Friday
    end_at DateTime.new(2016, 01, 03, 16) #Sunday
    latitude 59.8906898 #pr. Bolshevikov, 38к3, Sankt-Peterburg, Russia, 193315
    longitude 30.4911345
  end
end