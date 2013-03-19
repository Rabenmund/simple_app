class AddShortAndAbbToTeamTable < ActiveRecord::Migration
  def change
    add_column :teams, :short_name, :string
    add_column :teams, :abbreviation, :string
  end
end
