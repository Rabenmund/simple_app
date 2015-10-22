require 'spec_helper'

RSpec.describe SeasonEventing::FinishPlayerExchange do
  subject(:creator) do
    SeasonEventing::FinishPlayerExchange.new(season: season)
  end
end
