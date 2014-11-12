class PreviousSeason
  attr_reader :previous
  def initialize(year)
    @previous = Season.find_by(year: year-1)
  end

  def league(level)
    @previous.leagues.find_by(level: level)
  end
end
