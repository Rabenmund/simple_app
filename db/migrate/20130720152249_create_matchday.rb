class CreateMatchday < ActiveRecord::Migration
  def change
    create_table :matchdays do |t|
      t.integer :number, null: false
      t.datetime :start, null: false
      t.belongs_to :competition, null: false
      t.timestamps
    end
    add_index(:matchdays, :number)
  end
end
