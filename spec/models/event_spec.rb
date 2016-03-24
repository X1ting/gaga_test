require 'rails_helper'

RSpec.describe Event, type: :model do
  %i(name start_at end_at longitude latitude).each do |attr|
    it "must be invalid without #{attr}" do
      event = FactoryGirl.build(:event, attr => nil)
      event.valid?
      expect(event.errors[attr]).to include("can't be blank")
    end
  end

  it "address must be filled after input longitude, latitude" do
    event = FactoryGirl.create(:event)
    expect(event.address).to include("pr. Bolshevikov, 38к3, Sankt-Peterburg, Russia, 193315")
  end

  context "Filtering" do

    it 'shoud return event event_nearby_me' do
      event_nearby_me = FactoryGirl.create(:event)
      filter = {"in_distance" => {"distance" => 1, "client_longitude" => 30.4911345, "client_latitude" => 59.8906898 }}
      result = Event.filter(filter)
      expect(result.first).to eq(event_nearby_me)
    end

    it 'shoud return event on Sunday' do
      event_on_sunday = FactoryGirl.create(:event, :start_at => DateTime.new(2016, 01, 03, 16))
      filter = {"day_of_start" => {"day" => 0}}
      result = Event.filter(filter)
      expect(result.count).to eq(1)
      expect(result.first).to eq(event_on_sunday)
    end

    it 'shoud return event from 12 to 13 hours' do
      event = FactoryGirl.create(:event, :start_at => DateTime.new(2016,01,03,12,30), :end_at => DateTime.new(2016,01,03,13))
      filter = {"between_time" => {"start_at" => 12, "end_at" => "13"}}
      result = Event.filter(filter)
      expect(result.count).to eq(1)
      expect(result.first).to eq(event)
    end

    it 'shoulld not return event' do
      event = FactoryGirl.create(:event, :start_at => DateTime.new(2016,01,03,14,30))
      filter = {"between_time" => {"start_at" => 12, "end_at" => "13"}}
      result = Event.filter(filter)
      expect(result.count).to eq(0)
    end

    it 'shoud not be broken' do
      filter = {"between_time" => "", "bla" => "broke this", :in_distance => {"distance" => 1, "client_latitude" => ""}}
      result = Event.filter(filter)
      expect(result.class).to eq(Event::ActiveRecord_Relation)
    end
  end
end


