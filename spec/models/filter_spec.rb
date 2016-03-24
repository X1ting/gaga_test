require 'rails_helper'

RSpec.describe Filter, type: :model do
  it 'should not be created double' do
    filter = FactoryGirl.create(:filter)
    filter2 = FactoryGirl.build(:filter)
    expect(filter2.valid?).to eq(false)
  end
end


