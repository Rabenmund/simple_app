class Cup < Competition
  default_scope { where competable_type: "Cup" }
  has_many :draws
end
