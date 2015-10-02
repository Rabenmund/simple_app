module HumanRepository
  class Age
    def initialize(human: human)
      @human = human
    end

    def age_at(date)
      date.year - human.birthday.year
    end

    def days_at(date)
      date - human.birthday
    end

    private

    attr_reader :human
  end
end
