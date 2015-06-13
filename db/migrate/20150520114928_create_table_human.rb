class CreateTableHuman < ActiveRecord::Migration
  def change
    create_table :humen do |t|
      t.string :name
      t.date :birthday
      t.timestamps
    end
  end
end
