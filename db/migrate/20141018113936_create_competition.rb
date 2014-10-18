class CreateCompetition < ActiveRecord::Migration
  def change
    create_table :competitions do |t|
      t.string :name, null: false
      t.integer :year, null: false
      t.belongs_to :federation
      t.belongs_to :season
      t.timestamps
    end
  end
end
