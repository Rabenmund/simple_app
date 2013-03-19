class CreateTableMatchday < ActiveRecord::Migration
  def change
    create_table :matchdays do |t|
      t.integer :number, null: false, index: true
      t.references :competition, null: false

      t.timestamps
    end
  end

end
