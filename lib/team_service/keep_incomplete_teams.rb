require 'team_service/needed_players'
module TeamService
  class KeepIncompleteTeams
    def self.keep(teams)
      teams.keep_if {|team| NeededPlayers.new(team).need > 0}
    end
  end
end
