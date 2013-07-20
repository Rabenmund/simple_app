class CreateTableCompetitionsTeams < ActiveRecord::Migration
  create_table :leagues_teams, :id => false do |t|
    t.references :league, :team
  end
  add_index :leagues_teams, [:league_id, :team_id]
end
