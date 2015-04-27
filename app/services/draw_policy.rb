class DrawPolicy < Struct.new(:cup)
  def can_perform?(draw)
    cup.appointed_draws.first == draw
  end
end
