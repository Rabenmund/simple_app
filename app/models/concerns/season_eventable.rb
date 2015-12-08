module SeasonEventable
  extend ActiveSupport::Concern
  included do
    has_one :season_event, as: :eventable
    delegate :appointed_at, to: :season_event
  end
end

