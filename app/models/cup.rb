class Cup < Competition
  default_scope { where competable_type: "Cup" }
  has_many :draws

  MATCHDAYS = {6=> [21,81,130,207,249,287]}
  DRAWS = {6=> [1,22,82,131,208,250]}
  DRAW_TEXTS = ["Finale", "Halbfinale", "Viertelfinale", "Achtelfinale"]

  def prepare!
    number_of_matchdays.times do |number|
      create_matchdays!(number)
      draw = draws.create(name: "Auslosung DFB Pokal #{draw_text(number)}", start_date: start_date(DRAWS, number))
    end
  end

  private

  def matchday_schema
    MATCHDAYS
  end

  def draw_text(number)
    positive_number = number + 1
    DRAW_TEXTS[number_of_matchdays-positive_number] || "#{(positive_number).to_s}. Runde"
  end

  def number_of_matchdays
    {64=> 6}[members.size] || 0
  end

end
