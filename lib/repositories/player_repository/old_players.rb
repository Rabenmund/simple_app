module PlayerRepository
  module OldPlayers
    class << self
      def find_at(birthyear:)
        Player
          .joins(:human)
          .where("humen.birthday < ?", Date.new(birthyear))
      end
    end
  end
end
