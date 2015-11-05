class CreateCompetitionPlan < ActiveRecord::Migration
  def change
    create_table :competition_plans do |t|
      t.references :federation, null: false
      t.string :type, null: false
    end
  end
end
