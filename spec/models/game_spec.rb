require 'rails_helper'

RSpec.describe Game, type: :model do
  it 'should not be valid' do
    game = FactoryGirl.build(:game, :name => nil)
    expect(game.valid?).to eq(false)
  end
end
