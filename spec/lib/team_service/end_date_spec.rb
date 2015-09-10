require_relative "../../../lib/team_service/end_date"
require "active_support/core_ext/integer/time"
require 'spec_helper' # don't know where to find rails class for + years

RSpec.describe TeamService::EndDate do
  subject(:end_date) { TeamService::EndDate.new(start_date: date) }
  let(:date) { Date.new(2015,7,1) }

  it "provides a minimum 1 year in future date" do
    expect(end_date.end_date)
      .to be > (date+1.year-2.day)
  end
end
