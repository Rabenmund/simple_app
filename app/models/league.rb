class League < Competition
  before_create { self.competable_type = "League" }
  has_many :points, through: :games
  has_many :results

  MATCHDAYS = {34 => [0,7,14,36,39,46,53,67,74,81,88,95,109,116,123,130,137,172,179,183,186,193,200,207,214,221,228,242,249,256,263,270,277,284]}

  PLAN = {34 =>[
    [1,10,2,11,3,12,4,13,5,14,6,15,7,16,8,17,9,18],
    [18,8,16,6,15,5,14,4,13,3,12,2,11,1,10,9,17,7],
    [1,12,2,13,3,14,4,15,5,16,6,17,7,18,10,11,9,8],
    [18,6,16,4,15,3,14,2,13,1,12,10,11,9,8,7,17,5],
    [1,14,2,15,3,16,4,17,5,18,6,8,11,12,10,13,9,7],
    [18,4,16,2,15,1,14,10,13,11,12,9,7,6,8,5,17,3],
    [1,16,2,17,3,18,4,8,5,7,12,13,11,14,10,15,9,6],
    [18,2,16,10,15,11,14,12,13,9,6,5,7,4,8,3,17,1],
    [1,18,2,8,3,7,4,6,13,14,12,15,11,16,10,17,9,5],
    [18,10,16,12,15,13,14,9,5,4,6,3,7,2,8,1,17,11],
    [1,7,2,6,3,5,14,15,13,16,12,17,11,18,10,8,9,4],
    [18,12,16,14,15,9,4,3,5,2,6,1,7,10,8,11,17,13],
    [1,5,2,4,15,16,14,17,13,18,12,8,11,7,10,6,9,3],
    [18,14,16,9,3,2,4,1,5,10,6,11,7,12,8,13,17,15],
    [1,3,2,9,15,18,14,8,13,7,12,6,11,5,10,4,17,16],
    [18,16,2,1,3,10,4,11,5,12,6,13,7,14,8,15,9,17],
    [1,9,16,8,15,7,14,6,13,5,12,4,11,3,10,2,17,18],
  ]}

  def prepare!
    number_of_matchdays.times do |number|
      create_matchdays! number
      create_games! number
    end
  end

  def finished?
    games.any? && games.not_finished.empty?
  end

  def started?
    games.any? && games.finished.any?
  end

  def not_started?
    !started?
  end

  def live_board
    Point.joins(:team).select("teams.name, sum(points) as team_points, sum(goals) as team_goals, sum(against) as team_against, sum(diff) as team_diff, sum(win) as team_win, sum(draw) as team_draw, sum(lost) as team_lost").group("teams.name").where("points.league_id = #{self.id}").order("team_points DESC, team_diff DESC, team_goals DESC")
  end

  def finish!
    # TODO gegenwärtig nicht aufgerufen im programmablauf, nur in den seeds. Sollte im Rahmen eines End-of-Season aus dem live board calculiert werden.
    rank = 0
    live_board.each do |row|
      rank += 1
      team = Team.find_by(name: row.name)
      attributes = {team: team, level: level, year: season.year, points: row.team_points, goals: row.team_goals, against: row.team_against, diff: row.team_diff, win: row.team_win, draw: row.team_draw, lost: row.team_lost, rank: rank}
      result = results.find_by(team: team)
      result ?  result.update_attributes(attributes) : results.create(attributes)
    end
  end

  def result_board
    Result.joins(:team).select("teams.name, results.rank, results.year, results.points, results.goals, results.against, results.diff, results.win, results.draw, results.lost").where("results.league_id = #{self.id}").order("results.points DESC, results.diff DESC, results.goals DESC, results.rank ASC")
  end

  def rank_of_team(id: id)
    team = Team.find(id)
    (result_board.find_index {|r| r.name == team.name}) +1
  end

  def remaining_teams(up, down)
    teams.joins(:results).where("results.league_id = #{self.id}").where("results.rank" => (1+up)..(teams.size-down)).order("results.rank")
  end

  def promoted_teams(up)
    teams.joins(:results).where("results.league_id = #{self.id}").where("results.rank" => 1..up).order("results.rank")
  end

  def demoted_teams(down)
    teams.joins(:results).where("results.league_id = #{self.id}").where("results.rank" => (teams.size-down+1)..(teams.size)).order("results.rank")
  end

  def sub_leagues
    season.leagues.where(level: level+1)
  end

  def super_leagues
    season.leagues.where(level: level-1)
  end

  private

  def create_games!(iteration)
    number = iteration + 1
    matchday = matchdays.find_by(number: number)
    (teams.size / 2).times do |game|
      if number <= number_of_matchdays / 2
        matchday.games.create(home: ordered_teams[PLAN[number_of_matchdays][number-1][(game+1)*2-2]-1], guest: ordered_teams[PLAN[number_of_matchdays][number-1][(game+1)*2-1]-1])
      else
        matchday.games.create(home: ordered_teams[PLAN[number_of_matchdays][number-18][(game+1)*2-1]-1], guest: ordered_teams[PLAN[number_of_matchdays][number-18][(game+1)*2-2]-1], level: level)
      end
    end
  end

  def matchday_schema
    MATCHDAYS
  end

  def number_of_matchdays
    {18=> 34}[members.size] || 0
  end

end
