class CreateSeasonEvent < ActiveRecord::Migration
  def change
    create_table :season_events do |t|
      t.string :type
      t.datetime :performed_at
      t.belongs_to :season, null: false
      t.references :eventable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
