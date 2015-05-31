class CreateFederation < ActiveRecord::Migration
  def change
    create_table :federations do |t|
      t.string :name, null: false
      t.timestamps
    end
    add_index(:federations, :name)
  end
end
