class CreateTableMatchday < ActiveRecord::Migration
  create_table :matchdays do |t|
    t.integer :number, null: false
    t.references :league, null: false

    t.timestamps
  end
  add_index(:matchdays, :number)
  
end