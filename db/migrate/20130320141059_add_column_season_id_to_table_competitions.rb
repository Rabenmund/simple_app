class AddColumnSeasonIdToTableCompetitions < ActiveRecord::Migration
  def change
    add_column :competitions, :season_id, :integer
    add_index  :competitions, :season_id
  end

end
