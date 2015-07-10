class CreateContract < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.belongs_to :organization, index: true, null: false
      t.belongs_to :human, index: true, null: false
      t.datetime :from, null: false
      t.datetime :to, null: false
    end
  end
end
