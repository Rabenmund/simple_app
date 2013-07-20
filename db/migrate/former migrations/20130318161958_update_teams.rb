class UpdateTeams < ActiveRecord::Migration
  change_column :teams, :short_name, :string, null: false
  change_column :teams, :abbreviation, :string, null: false
end
