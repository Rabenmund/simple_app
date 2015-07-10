class LogicalDate < ActiveRecord::Base
  def self.year
    date.year
  end

  def self.current_season_year
    current_date = date
    current_date.yday > 212 ? current_date.year + 1 : current_date.year
  end

  def self.date
    first.try(:logical_date) || Date.today
  end
end
