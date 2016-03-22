class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.datetime :start_at, null: false
      t.datetime :end_at, null: false
      t.decimal :longitude, null: false
      t.decimal :latitude, null: false
      t.string :address, null: false

      t.timestamps null: false
    end
  end
end
