class CreateEvent < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :eventable_id, null: false
      t.string :eventable_type, null: false
      t.datetime :perform_at, null: false
    end
  end
end
