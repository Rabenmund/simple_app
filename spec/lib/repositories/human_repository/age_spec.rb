require 'spec_helper'

RSpec.describe HumanRepository::Age do
  subject(:repo) { HumanRepository::Age.new(human: human) }

  let(:human) { create :human, birthday: Date.new(1969,3,31) }
  let(:date) { Date.new(2015,9,1) }

  it "provides a humans age" do
    expect(repo.age_at(date)).to eq 46
  end

  it "provides a humans age in days" do
    expect(repo.days_at(date)).to eq 16955
  end
end
