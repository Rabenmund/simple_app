class AddIndexToGames < ActiveRecord::Migration
  def change
    add_index(:games, :home_id)
    add_index(:games, :guest_id)
  end
end
