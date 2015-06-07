class CreateProfession < ActiveRecord::Migration
  def change
    create_table :professions do |t|
      t.references :professionable, polymorphic: true, index: true
      t.belongs_to :human
    end
  end
end
