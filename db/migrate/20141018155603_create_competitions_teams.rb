class CreateCompetitionsTeams < ActiveRecord::Migration
  def change
    create_table :competitions_teams do |t|
      t.belongs_to :competition
      t.belongs_to :team
    end
  end
end
