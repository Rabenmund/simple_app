class CreateGermanFamilyName < ActiveRecord::Migration
  def change
    create_table :german_family_names do |t|
      t.string :name
      t.integer :weight
    end
  end
end
