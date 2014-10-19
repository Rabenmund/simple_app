class CreateDraw < ActiveRecord::Migration
  def change
    create_table :draws do |t|
      t.string :name, null: false
      t.belongs_to :cup
    end
  end
end
