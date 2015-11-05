module CompetitionPlanning

  class DfbPlan < CompetitionPlan
    def leagues
      [
        MethodicalHash.new({
          level: 1,
          name: "Bundesliga",
          teams_no: 18,
          relegators_no: 3,
          promoters_no: 0
        }),
        MethodicalHash.new({
          level: 2,
          name: "2.Bundesliga",
          teams_no: 18,
          relegators_no: 3,
          promoters_no: 3
        }),
        MethodicalHash.new({
          level: 3,
          name: "3.Bundesliga",
          teams_no: 18,
          relegators_no: 3,
          promoters_no: 3
        }),
      ]
    end

    def cups
      [
        MethodicalHash.new({
          level: 1,
          name: "DFB Pokal",
          teams_no: 64
        }),
      ]
    end
  end
end
