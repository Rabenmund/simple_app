class CreateAppointment < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.references :appointable, polymorphic: true, index: true
      # t.integer :competition_id
      t.datetime :appointed_at, null: false
    end
    # add_index :appointments, :competition_id
    add_index :appointments, :appointed_at
  end
end
