module PlayerRepository
  # TODO yep, die klasse ist zu fett

  class Factory
    TYPES = [:keeper, :defender, :midfielder, :attacker]
    AGE = { young: [17,20], random: [17,35] }

    def initialize(date:, age: nil, type: nil, params: {})
      age = AGE.include?(age) ? AGE[age] : AGE[:young]
      @date = date
      @params = params
      @type = TYPES.include?(type) ? type : random_type
      @birthday = params[:birthday] || random_birthday(age.first, age.last)
    end

    def create
      create_player(create_human)
    end

    private

    attr_reader :params, :type, :birthday, :human, :date

    def random_type
      case rand(23)
      when 0..2
        :keeper
      when 3..10
        :defender
      when 11..18
        :midfielder
      when 19..22
        :attacker
      end
    end

    def random_birthday(min, max)
      Birthday.random(date: date, min: min, max: max)
    end

    def create_human
      @human ||= HumanRepository::Creator.create(
        name: params[:name] || name,
        birthday: birthday
      )
    end

    def create_player(human)
      @player ||= PlayerRepository::Creator.create(
        human: human,
        keeper: params[:keeper] || strength(:keeper),
        defense: params[:defense] || strength(:defender),
        midfield: params[:midfield] || strength(:midfielder),
        attack: params[:attack] || strength(:attacker)
      )
    end

    def name
      "#{Name.prename} #{Name.family}"
    end

    def strength(should)
      should == type ? strength_by_age : 0
    end

    def strength_by_age
      InitialStrength.for_age(age_in_days)
    end

    def age_in_days
      HumanRepository::Age.new(human: human).days_at(date)
    end

  end
end
