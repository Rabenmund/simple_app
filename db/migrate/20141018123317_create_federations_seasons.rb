class CreateFederationsSeasons < ActiveRecord::Migration
  def change
    create_join_table :federations, :seasons do |t|
      t.index :federation_id
      t.index :season_id
    end
  end
end
