module SeasonEventing
  class GameEvent < SeasonEvent
    def call
      fail NoImplementationError
      # implement here the game perform action
    end
  end
end
