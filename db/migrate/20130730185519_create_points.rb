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

      t.references :game, null: false
      t.references :team, null: false
      t.references :league, null: false

      t.timestamps
    end
  end

end
