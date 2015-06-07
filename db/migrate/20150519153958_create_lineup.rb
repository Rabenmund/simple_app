class CreateLineup < ActiveRecord::Migration
  def change
    create_table :lineups do |t|
      t.belongs_to :team
      t.belongs_to :game
      t.integer :initiative
      t.integer :attacking
      t.integer :defending
      t.timestamps
    end
    add_index(:lineups, [:game_id, :team_id])
  end
end
