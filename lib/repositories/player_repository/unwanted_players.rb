module PlayerRepository
  module UnwantedPlayers
    class << self
      def without_contract_since(date)
        Player
          .without_contract_at(date)
      end
    end
  end
end
