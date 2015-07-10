class CreateSeason < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.integer :year, null: false
      t.datetime :start_date
      t.datetime :end_date
      t.timestamps
    end
    add_index(:seasons, :year)
  end
end
