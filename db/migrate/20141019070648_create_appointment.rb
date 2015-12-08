class CreateAppointment < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.references :appointable, polymorphic: true, index: true
      t.datetime :appointed_at, null: false
    end
    add_index :appointments, :appointed_at
  end
end
