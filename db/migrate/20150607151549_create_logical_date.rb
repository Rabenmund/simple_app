class CreateLogicalDate < ActiveRecord::Migration
  def change
    create_table :logical_dates do |t|
      t.datetime :logical_date
    end
  end
end
