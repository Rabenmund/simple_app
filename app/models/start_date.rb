class StartDate
  def initialize(season_start, since_start_days)
    @season_start = season_start
    @start = season_start + since_start_days
  end

  def start_date_auto_shift
    @start += (add_extra_time_at_different_wday || 0)
  end

  def start_date_extra_days(extra_days=0)
    @start += extra_days.days
  end

  def start_date_extra_time(extra_time=0)
    @start += extra_time.minutes
  end

  private

  def add_extra_time_at_different_wday
    5.hours if @start.wday != @season_start.wday
  end
end
