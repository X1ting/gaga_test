class CreateFilters < ActiveRecord::Migration
  def change
    create_table :filters do |t|
      t.integer :start_time
      t.integer :end_time
      t.integer :distance
      t.integer :day_of_start
      t.string :digest, index: true
      t.timestamps null: false
    end
  end
end
