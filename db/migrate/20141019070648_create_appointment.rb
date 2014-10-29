class CreateAppointment < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.integer :appointable_id, null: false
      t.string :appointable_type, null: false
      t.integer :competition_id
      t.datetime :appointed_at, null: false
    end
  end
end
