class CreateLineupActor < ActiveRecord::Migration
  def change
    create_table :lineup_actors do |t|
      t.string :type, null: false
      t.integer :lineup_id
      t.references :actorable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
