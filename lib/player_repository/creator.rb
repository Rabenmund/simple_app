module PlayerRepository
  module Creator
    class << self
      def create(params)
        Player.create params
      end
    end
  end
end
