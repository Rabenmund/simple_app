module CompetitionPlanning

  class DfbPlan < CompetitionPlan
    def leagues
      [
        MethodicalHash.new({
          level: 1,
          name: "Bundesliga",
          teams_no: 18,
          promoted_from_sub: 3,
        }),
        MethodicalHash.new({
          level: 2,
          name: "2.Bundesliga",
          teams_no: 18,
          promoted_from_sub: 3,
        }),
        MethodicalHash.new({
          level: 3,
          name: "3.Bundesliga",
          teams_no: 18,
          promoted_from_sub: 3,
        }),
      ]
    end

    def cups
      [
        MethodicalHash.new({
          level: 1,
          qualified: MethodicalHash.new(
            leagues: {1 => 18, 2 => 18, 3 => 18, 4 => 10}),
          name: "DFB Pokal",
          teams_no: 64
        }),
      ]
    end
  end
end
