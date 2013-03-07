class CreateJoinTableCompetitionsTeams < ActiveRecord::Migration
  create_table :competitions_teams, :id => false do |t|
    t.references :competition, :team
  end

  add_index :competitions_teams, [:competition_id, :team_id]
end
