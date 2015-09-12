class CreateTeam < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.belongs_to :federation, index: true, null: false
      t.string :name, null: false
      t.string :short_name, null: false
      t.string :abbreviation, null: false
      t.integer :reputation, default: 0
      t.timestamps
    end
    add_index(:teams, :name)
  end

end
