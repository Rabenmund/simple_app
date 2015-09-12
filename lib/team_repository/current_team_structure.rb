module TeamRepository
  module CurrentTeamStructure
    class << self
      def current_team_structure(id:, date:)
        team = Team.find(id)
        team_structure = TeamStructure.new
        %w[keepers defenders midfielders attackers].each do |type|
          team_structure
            .send(type+"=", team.players_at(date).send(type).size)
        end
        team_structure
      end
    end
  end
end
