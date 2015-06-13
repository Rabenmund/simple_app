require 'active_support/all'

class Birthday
  def self.random(max: 20, min: 17, date: LogicalDate.date)
    from = date - max.years
    to = date - min.years
    rand(from..to)
  end

  def self.normal_distribution(medium: 28, deviation: 2.6, date: LogicalDate.date)
    year = Distribution::Normal.rng(medium, deviation).call.to_i
    (date - year.years) + (rand(365)-183).days
  end
end
