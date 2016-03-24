class AssociativeTableGamesAndFilter < ActiveRecord::Migration
  def change
    create_table :filters_games, id: false do |t|
      t.belongs_to :filter, index: true
      t.belongs_to :game, index: true
    end
  end
end
