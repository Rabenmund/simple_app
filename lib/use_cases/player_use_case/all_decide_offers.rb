module PlayerUseCase
  module AllDecideOffers
    class << self
      def decisions
        PlayerRepository::OpenOffers.all.each do |player|
          PlayerUseCase::DecideOffers.new(player: player).decide!
        end
      end
    end
  end
end
