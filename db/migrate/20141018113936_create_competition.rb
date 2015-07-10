class CreateCompetition < ActiveRecord::Migration
  def change
    create_table :competitions do |t|
      t.string :name, null: false
      t.string :type, null: false
      t.integer :level#, null: false
      t.belongs_to :federation, index: true, null: false
      t.belongs_to :season, index: true, null: false
      t.datetime :start
      t.timestamps
    end
    # TODO funktioniert, aber genaue Auswirkung auf perf prüfen
    # add_index(:competitions,[:federation_id, :level], unique: true)
  end
end
