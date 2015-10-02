class CreateTableHuman < ActiveRecord::Migration
  def change
    create_table :humen do |t|
      t.string :name, null: false
      t.date :birthday, null: false
      t.timestamps
    end
  end
end
