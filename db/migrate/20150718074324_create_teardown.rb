class CreateTeardown < ActiveRecord::Migration
  def change
    create_table :teardowns do |t|
      t.references :teardownable, polymorphic: true, index: true
      t.datetime :appointed_at, null: false
    end
  end
end
