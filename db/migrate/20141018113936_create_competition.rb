class CreateCompetition < ActiveRecord::Migration
  def change
    create_table :competitions do |t|
      t.string :name, null: false
      t.string :type, null: false
      t.integer :level
      t.belongs_to :federation
      t.belongs_to :season
      t.datetime :start
      t.timestamps
    end
  end
end
