class CreateFederationsSeasons < ActiveRecord::Migration
  def change
    create_table :federations_seasons, id: false do |t|
      t.belongs_to :federation
      t.belongs_to :season
    end
  end
end
