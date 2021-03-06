class DFBPattern

  LEAGUES = [
    {
      level: 1,
      name: "Bundesliga",
      teams: 18,
      down: 3,
      up: 0
    },
    {
      level: 2,
      name: "2. Bundesliga",
      teams: 18,
      down: 3,
      up: 3
    },
    {
      level: 3,
      name: "3. Bundesliga",
      teams: 18,
      down: 3,
      up: 3},
  ]

  def initialize(season: season)
    @season = season
    @previous = season.previous
    @dfb = Federation.find_by(name: "DFB")
  end

  def prepare!
    @season.federations << @dfb
    create_cups
    create_leagues
  end

  private

  def create_cups
    @dfb_pokal = @dfb.cups.create(
      name: "DFB Pokal",
      level: 1,
      season: @season,
      start: @season.start_date)
    @dfb_pokal.teams << @dfb.teams.
      joins(:competitions).
      where("competitions.level" => 1..3, "competitions.type" => "League", "competitions.season_id" => @previous.id)
    fill_with_random_teams(10, @dfb.teams, @dfb_pokal.teams)
    @dfb_pokal.prepare!
  end

  def create_leagues
    LEAGUES.each do |league|
      @league = @dfb.leagues.create(
        season: @season,
        name: league[:name],
        level: league[:level],
        # TODO gruselig - refactor!
        start: @season.start_date
      )
      get_teams(@league, league[:up], league[:down], league[:teams])
      @season.leagues << @league
      @league.tearup!
    end
  end

  def get_teams(league, up, down, members)
    if league.previous
      # TODO Solange nur eine Liga darüber oder darunter steht funktioniert das. Bei mehreren Ligen muss man eine regionale Zugehörigkeit entwickeln.
      teams = []
      teams = league.previous.remaining_teams(up, down).pluck :id
      additional_teams = teams_from_sub_league(league.previous, down)
      teams = teams + additional_teams.pluck(:id) if additional_teams.any?
      additional_teams = teams_from_super_league(league.previous, up)
      teams = teams + additional_teams.pluck(:id) if additional_teams.any?
      randomize_array(teams)
    end
    fill_with_random_teams((members-@league.teams.size), @dfb.teams, @league.teams)
  end

  def previous_teams
    if @previous.id == 1
      return @dfb.teams.where(id: 1..57)
    end
    Team.
      joins(:competitions).
      where("competitions.season_id = #{@previous.previous.id}").
      where("competitions.type = 'League'").
      order(:id)
  end

  def teams_from_sub_league(league, up)
    sub_league = league.sub_leagues.first
    return [] unless sub_league
    sub_league.promoted_teams(up)
  end

  def teams_from_super_league(league, down)
    super_league = league.super_leagues.first
    return [] unless super_league
    super_league.demoted_teams(down)
  end

  def fill_with_random_teams(no, all_teams, selected_teams)
    no.times do
      puts "-> #{@dfb.teams.count} - #{selected_teams.size} - #{previous_teams.count}"
      rest = @dfb.teams - selected_teams - previous_teams
      selected_teams << rest[Random.rand(1...rest.count)-1]
    end
  end

  def randomize_array(teams=[])
    teams.size.times do
      id = Random.rand(1..teams.size)-1
      @league.teams << Team.find(teams[id])
      teams.delete_at id
    end
  end

end
