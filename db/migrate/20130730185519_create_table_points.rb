class CreateTablePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.integer :points
      t.references :game, null: false
      t.references :team, null: false

      t.timestamps
    end
  end

end
