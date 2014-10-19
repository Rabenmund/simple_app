class Relegation < Competition
  default_scope { where competable_type: "Relegation" }
end
