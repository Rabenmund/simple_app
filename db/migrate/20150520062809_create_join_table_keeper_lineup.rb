class CreateJoinTableKeeperLineup < ActiveRecord::Migration
  def change
    create_join_table :keepers, :lineups do |t|
      t.index :keeper_id
      t.index :lineup_id
    end
  end
end
