class CreateTableGame < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :home_id, null: false, index: true
      t.integer :guest_id, null: false, index: true
      t.integer :home_goals
      t.integer :guest_goals
      t.references :matchday, null: false

      t.timestamps
    end
  end

end

