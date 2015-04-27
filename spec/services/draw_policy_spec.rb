require 'spec_helper'

describe DrawPolicy do
  let(:cup) { create :cup }
  let(:matchday) { create :matchday, competition: cup }
  let(:draw) { create :draw, cup: cup, matchday: matchday }
  let(:draw_policy) { DrawPolicy.new(cup) }

  it "knows that a draw can be performed" do
    expect(draw_policy.can_perform?(draw)).to eq true
  end

  it "knows that a draw cannot be performed" do
    another_matchday = create :matchday, competition: cup
    another_draw = create :draw, cup: cup, matchday: another_matchday
    expect(draw_policy.can_perform?(draw)).to eq false
  end
end
