module SeasonUseCase
  module MatchdayStart
    class << self

      DAYS_SINCE_START = {
        league: {
          1 => {
            34 => [
              0, 14,21, 35,42,49,56,63,70,77,84,91, 105,112,119,126,133,
              154,161,168,175,182,189,196, 217,224,231,238,245,252,259,
              273,280,287
            ]
          },
          2 => {
            34 => [
              1, 15,22, 36,43,50,57,64,71,78,85,92, 106,113,120,127,134,
              155,162,169,176,183,190,197, 218,225,232,239,246,253,260,
              274,281,288
            ]
          },
          3 => {
            34 => [
              1, 15,22, 36,43,50,57,64,71,78,85,92, 106,113,120,127,134,
              155,162,169,176,183,190,197, 218,225,232,239,246,253,260,
              274,281,288
            ]
          }
        },
        cup: {
          1 => {
            6 => [
              7,73,136,178,241,294
            ]
          }
        },
        national: {
          1 => {
            10 => [
              25,28, 95,98, 137,140, 200,203, 263,266
            ]
          }
        },
        national_cup: {
          1 => {
            7 => [
              301,304,308,312,315,319,322
            ]
          }
        }
      }

      def date_for(type:, number_all:, competition_start:, number:, level: 1)
        competition_start + DAYS_SINCE_START[type][level][number_all][number-1]
      end

    end
  end
end

