class CreateSeasonEvent < ActiveRecord::Migration
  def change
    create_table :season_events do |t|
      t.string :type, null: false
      t.belongs_to :season, null: false
      t.timestamps
    end
  end
end
