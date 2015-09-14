class CreatePlayer < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.integer :keeper, default: 0
      t.integer :defense, default: 0
      t.integer :midfield, default: 0
      t.integer :attack, default: 0
      t.boolean :retired, default: false
      t.timestamps
    end
  end
end
