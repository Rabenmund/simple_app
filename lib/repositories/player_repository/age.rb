module PlayerRepository
  module Age
    class << self
      def old_players(birthyear:)
        Player
          .joins(:human)
          .where("humen.birthday < ?", Date.new(birthyear))
      end
    end
  end
end
