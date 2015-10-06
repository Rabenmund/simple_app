module PlayerRepository
  module OldPlayers
    class << self
      def active_and_born_in(birthyear:)
        Player
          .joins(:human)
          .where("humen.birthday < ?", Date.new(birthyear))
          .where(retired: false)
      end
    end
  end
end
