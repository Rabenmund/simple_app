class CreateGame < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :home_id, null: false
      t.integer :guest_id, null: false
      t.integer :home_goals
      t.integer :guest_goals
      t.integer :home_half_goals
      t.integer :guest_half_goals
      t.integer :home_full_goals
      t.integer :guest_full_goals
      t.integer :home_xtra_goals
      t.integer :guest_xtra_goals
      t.integer :second, default: 0
      t.datetime :performed_at
      t.boolean :finished, default: false
      t.references :matchday, null: false
      t.timestamps
    end
    add_index(:games, :home_id)
    add_index(:games, :guest_id)
  end

end

