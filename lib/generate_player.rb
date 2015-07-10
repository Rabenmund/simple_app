class GeneratePlayer

  def initialize(medium = 1, birthday: Birthday.random)
    @medium = medium
    @birthday = birthday
  end

  def random
    selection = rand(23)
    case (selection+1)
    when 1..3
      keeper
    when 4..11
      defender
    when 12..19
      midfielder
    when 20..23
      attacker
    end
  end

  def keeper
    Player.create!(
      human: human,
      keeper: strength
    )
  end

  def defender
    Player.create!(
      human: human,
      defense: strength,
      midfield: lower_strength,
      attack: lower_strength,
    )
  end

  def midfielder
    Player.create!(
      human: human,
      defense: lower_strength,
      midfield: strength,
      attack: lower_strength,
    )
  end

  def attacker
    Player.create!(
      human: human,
      defense: lower_strength,
      midfield: lower_strength,
      attack: strength,
    )
  end

  private

  attr_reader :medium, :birthday

  def human
    @human ||= Human.create!(
      name: "#{Name.prename} #{Name.family}",
      birthday: birthday
    )
  end

  def age
    @age ||= human.age
  end

  def strength
    @strength ||= InitialStrength.for_age(age, medium)
  end

  def lower_strength
    (strength * rand(0)).to_i
  end

end
