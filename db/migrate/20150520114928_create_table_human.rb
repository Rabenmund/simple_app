class CreateTableHuman < ActiveRecord::Migration
  def change
    create_table :humen do |t|
      t.string :name
      t.timestamps
    end
  end
end
