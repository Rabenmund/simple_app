module LeagueUseCase
  class NotEnoughTeamsError < StandardError; end

  class LeaguePlanner

    def initialize(season:, previous:, federation:)
      @season = season
      @previous = previous
      @federation = federation
    end

    def with_plan(plans)
      relegators = []
      promoters_to_super = []
      plans.each do |plan|

        previous_league = previous_league_for plan.name

        if previous_league
          promoters = LeagueUseCase::Promoters
            .new(league: previous_league)
            .first(plan.promoted_from_sub)

          teams_size = plan.teams_no - (relegators.size +
                                        plan.promoted_from_sub)

          remainers = LeagueUseCase::Remainers
            .new(league: previous_league)
            .from(promoters_no: relegators.size,
                     size: teams_size)
        end

        members = relegators + promoters + remainers
        create_league_with members, plan

        relegators = previous_league.teams - members - promoters_to_super

        promoters_to_super = promoters
      end
    end

    private

    attr_reader :season, :previous, :federation
    attr_accessor :teams, :relegators, :promoters, :candidates

    def previous_league_for(name)
      previous_league = LeagueRepository::Finder
        .by_name(
          season: previous,
          name: name
        )
    end

    def create_league_with(members, plan)
      creator = LeagueRepository::LeagueCreator
        .new(
          attributes: {
            level: plan.level,
            name: plan.name,
            season: season,
            federation: federation,
            start: season.start_date
          }
        )
      creator.save!
      creator.add_teams members
      creator.ensure_team_size(plan.teams_no)
      creator.plan_games_for(members)
    end

  end
end
