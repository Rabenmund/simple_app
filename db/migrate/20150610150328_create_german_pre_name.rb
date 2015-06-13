class CreateGermanPreName < ActiveRecord::Migration
  def change
    create_table :german_pre_names do |t|
      t.string :name
      t.integer :weight
    end
  end
end
