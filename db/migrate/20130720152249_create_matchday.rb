class CreateMatchday < ActiveRecord::Migration
  create_table :matchdays do |t|
    t.integer :number, null: false
    t.belongs_to :competition, null: false
    t.timestamps
  end
  add_index(:matchdays, :number)

end
