class CreateContract < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.belongs_to :organization, null: false
      t.belongs_to :human, null: false
    end
  end
end
