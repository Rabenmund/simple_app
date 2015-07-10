class CreateDraw < ActiveRecord::Migration
  def change
    create_table :draws do |t|
      t.string :name, null: false
      t.datetime :performed_at
      t.boolean :finished, default: false
      t.belongs_to :cup, index: true, null: false
      t.belongs_to :matchday, index: true, null: false
    end
  end
end
