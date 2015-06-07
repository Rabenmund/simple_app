class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.integer :points
      t.integer :goals
      t.integer :against
      t.integer :diff
      t.integer :win
      t.integer :draw
      t.integer :lost
      t.integer :level

      t.references :game, null: false
      t.references :team, null: false
      t.references :league, null: false, index: true

      t.timestamps
    end
    add_index :points, [:game_id, :team_id]
    add_index :points, :team_id
  end

end
