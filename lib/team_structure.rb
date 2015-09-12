class TeamStructure < Struct.new :keepers, :defenders, :midfielders, :attackers
  class CannotSubtractClassError < StandardError; end

  def -(team_structure)
    raise CannotSubtractClassError unless team_structure.class == self.class
    self.keepers -= team_structure.keepers
    self.defenders -= team_structure.defenders
    self.midfielders -= team_structure.midfielders
    self.attackers -= team_structure.attackers
    return self
  end

  def size
    self.keepers + self.defenders + self.midfielders + self.attackers
  end

  def take_type!
    %w[keepers defenders midfielders attackers].each do |type|
      if self.send(type) > 0
        self.send(type+"=", self.send(type) - 1)
        return type.singularize.to_sym
      end
    end
    return nil
  end

end
