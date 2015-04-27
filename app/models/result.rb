class Result < ActiveRecord::Base
  belongs_to :team
  belongs_to :league

  def self.engage!(league)
    league.board.each do |r|
      team = Team.find_by(name: r.name)
      result = find_or_create_by(team: team, league: league)
      attr = {team: team, league: league, points: r.team_points, goals: r.team_goals, against: r.team_against, diff: r.team_diff, win: r.team_win, draw: r.team_draw, lost: r.team_lost, level: league.level}
      result.update_attributes(attr)
    end
  end
end
