require 'team_service/needs'

module TeamService
  class Incompleted
    def initialize(ids:, date:)
      @ids = ids
      @date = date
    end

    def teams
      ids.keep_if {|id| needs_player? id }
    end

    private

    attr_reader :ids, :date

    def needs_player?(id)
      TeamService::Needs.new(id: id, date: date).players?
    end
  end
end
