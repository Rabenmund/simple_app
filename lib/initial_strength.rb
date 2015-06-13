class InitialStrength

  DEVIATION=100
  # TODO Refactor by mathematical solution
  FACTOR = {
    17 => 17,
    18 => 17,
    19 => 16,
    20 => 16,
    21 => 15,
    22 => 15,
    23 => 15,
    24 => 14,
    25 => 14,
    26 => 13,
    27 => 13,
    28 => 13,
    29 => 13,
    30 => 14,
    31 => 14,
    32 => 15,
    33 => 15,
    34 => 16,
    35 => 16,
    36 => 17,
  }

  def self.for_age(age, medium_factor=1)
    # intention to reflect highest efficiency between 26 and 29
    years = age/365
    factor = FACTOR[years] || 18
    # optimized for 6800 days (18)
    # 6800/17 = 400 (medium of normal distribution)
    medium = (age/factor).to_i*medium_factor
    Distribution::Normal.rng(medium, DEVIATION).call.to_i
  end
end
