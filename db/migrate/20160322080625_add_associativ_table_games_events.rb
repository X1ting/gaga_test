class AddAssociativTableGamesEvents < ActiveRecord::Migration
  def change
    create_table :events_games, id: false do |t|
      t.belongs_to :event, index: true
      t.belongs_to :game, index: true
    end
  end
end
