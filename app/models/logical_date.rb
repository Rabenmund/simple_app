class LogicalDate < ActiveRecord::Base
  def self.year
    first.logical_date.year
  end

  def self.date
    first ? first.logical_date.to_date : Date.today
  end
end
