class CreateOrganization < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.references :organizable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
