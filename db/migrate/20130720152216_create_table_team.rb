class CreateTableTeam < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.string :short_name, null: false
      t.string :abbreviation, null: false
      t.timestamps
    end
  end

end
