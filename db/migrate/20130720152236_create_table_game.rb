class CreateTableGame < ActiveRecord::Migration
  class CreateTableGame < ActiveRecord::Migration
    def change
      create_table :games do |t|
        t.integer :home_id, null: false
        t.integer :guest_id, null: false
        t.integer :home_goals
        t.integer :guest_goals
        t.references :matchday, null: false

        t.timestamps
      end
      add_index(:games, :home_id)
      add_index(:games, :guest_id)
    end

  end

end
