class Cup < Competition
  has_many :draws

  MATCHDAYS = {6=> [21,81,130,207,249,287]}
  DRAWS = {6=> [1,22,82,131,208,250]}
  DRAW_TEXTS = ["Finale", "Halbfinale", "Viertelfinale", "Achtelfinale"]

  def winning_teams_at(matchday)
    teams.joins("JOIN games ON games.home_id=teams.id")
      .where("games.matchday_id = #{matchday.id}")
      .where("games.home_goals > games.guest_goals") +
    teams.joins("JOIN games ON games.guest_id=teams.id")
      .where("games.matchday_id = #{matchday.id}")
      .where("games.home_goals < games.guest_goals")
  end

  def drawed_teams_at(matchday)
    teams.joins(
            "JOIN games
             ON (games.home_id=teams.id OR
                 games.guest_id=teams.id)")
      .where("games.matchday_id = #{matchday.id}")
  end

  def prepare!
    number_of_matchdays.times do |number|
      matchday = create_matchday!(number)

      draws.create(
        name: "Auslosung #{draw_text(number)}",
        performed_at:
          StartDate.new(
            start,
            draw_days_since_start(number)
          ).start_date_extra_time(180),
       matchday: matchday
      )
    end
  end

  def appointed_draws
    draws.
      joins(:appointment).
      order('appointments.appointed_at ASC' )
  end

  private

  def draw_days_since_start(number)
    DRAWS[number_of_matchdays][number].days
  end

  def matchday_schema
    MATCHDAYS
  end

  def draw_text(number)
    positive_number = number + 1
    DRAW_TEXTS[number_of_matchdays-positive_number] || "#{(positive_number).to_s}. Runde"
  end

  def number_of_matchdays
    {64=> 6}[members.size] || 0
  end

end
