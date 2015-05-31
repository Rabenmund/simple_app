class CreateResults < ActiveRecord::Migration
  def change
    create_table :results do |t|
      t.integer :points, default: 0
      t.integer :goals, default: 0
      t.integer :against, default: 0
      t.integer :diff, default: 0
      t.integer :win, default: 0
      t.integer :draw, default: 0
      t.integer :lost, default: 0
      t.belongs_to :team, null: false
      t.belongs_to :league, null: false
      t.integer :level
      t.integer :year
      t.integer :rank
      t.timestamps
    end
    add_index(:results, :team_id)
  end
end
