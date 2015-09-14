module PlayerRepository
  module Age
    class << self

      def old_players(birthyear:)
        Player
          .joins(:human)
          .where("humen.birthday < ?", Date.new(birthyear))
          .ids
      end

      def years_over(id:, birthyear:)
        over = birthyear - Player.find(id).birthday.year
        over > 0 ? over : 0
      end

    end
  end
end
