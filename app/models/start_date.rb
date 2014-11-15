class StartDate
  def initialize(season_start, since_start_days)
    @season_start = season_start
    @start = season_start + since_start_days
  end

  def start_date
    @start + (add_extra_time_at_different_wday || 0)
  end

  private

  def add_extra_time_at_different_wday
    5.hours if @start.wday != @season_start.wday
  end
end
