class CreateOffer < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.belongs_to :player, index: true, null: false
      t.belongs_to :team, index: true, null: false
      t.integer :reputation
      t.integer :negotiation_round
      t.boolean :negotiated, default: false
      t.boolean :accepted, default: false
      t.timestamps
    end
  end
end
