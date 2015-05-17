class Draw < ActiveRecord::Base

  include Appointable

  belongs_to :cup
  belongs_to :matchday
  has_many :games, through: :matchday
  has_one :season, through: :cup

  validates :name, presence: true
  validates :cup, presence: true

  def competition
    cup
  end

  def finish!
    update_attributes(finished: true)
    appointment.destroy if appointment
  end

  # TODO gruselig - weg damit
  def perform!
    # puts "draw#perform: #{self.name}"
    # puts "finished?: #{finished?}"
    unless finished?
      undrawed = undrawed_teams
      finish! if undrawed.size < 2
    end
    # puts "2.finished?: #{finished?}"
    return false if finished?
    update_attributes(performed_at: performed_at + 1.minute)
    home, guest = random_teams(undrawed)
    game = matchday.games.create(
      home: home,
      guest: guest,
      performed_at: matchday.start,
      decision: true,
      level: cup.level
    )
    # puts "Game created: #{game.inspect}"
    return home, guest
  end

  def finished?
    finished == true
  end

  def can_be_performed?
    return false if finished?
    return true if is_first?
    !matchday.unfinished_previous_matchdays?
  end

  def is_first?
    matchday.number == 1
  end

  private

  def random_teams(undrawed)
    home_position = random_until(undrawed.size)
    home = undrawed[home_position-1]
    guest_position = random_until(undrawed.size, home_position)
    guest = undrawed[guest_position-1]
    return home, guest
  end

  def undrawed_teams
    winning_teams - cup.drawed_teams_at(matchday)
  end

  def winning_teams
    @winning_teams ||= matchday.number == 1 ? cup.teams : cup.winning_teams_at(matchday.previous)
  end

  def random_until(size, ignore=nil)
    number = Random.new.rand(1..size)
    number == ignore ? random_until(size, ignore) : number
  end

end
