class AddColumnPlanPositionsToCompetitions < ActiveRecord::Migration
  def change
    add_column :competitions, :plan_positions, :text
  end
end
