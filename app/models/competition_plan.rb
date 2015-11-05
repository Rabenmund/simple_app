class CompetitionPlan < ActiveRecord::Base
  belongs_to :federation

  def leagues
    # example:
    # [
    #   {
    #     level: 1,
    #     name: "Bundesliga",
    #     teams_no: 18,
    #     relegators_no: 3,
    #     promoters_no: 0
    #   }
    # ]

    []
  end

  def cups
    # example:
    # [
    #   {
    #     level: 1,
    #     name: "DFB Pokal",
    #     teams_no: 64
    #   }
    # ]

    []
  end

end
