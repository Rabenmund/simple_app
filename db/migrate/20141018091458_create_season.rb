class CreateSeason < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.integer :year, null: false
      t.datetime :start
      t.timestamps
    end
  end
end
