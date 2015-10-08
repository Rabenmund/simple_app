module HumanRepository
  module Creator
    class << self
      def create(params)
        Human.create params
      end
    end
  end
end

