class AddSecondToGame < ActiveRecord::Migration
  def change
    add_column :games, :second, :integer, default: 0
  end
end
