class Draw < ActiveRecord::Base

  include Appointable

  belongs_to :cup
  belongs_to :matchday
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

  def perform!
    return false if finished?
    update_attributes(performed_at: performed_at + 1.minute)
    home, guest = random_teams
    matchday.games.create(home: home, guest: guest, performed_at: matchday.start)
    finish! if undrawed_teams.size < 2
    return home, guest
  end

  def finished?
    finished == true
  end

  private

  def random_teams
    home_position = random_until(undrawed_teams.size)
    home = undrawed_teams[home_position-1]
    guest_position = random_until(undrawed_teams.size, home_position)
    guest = undrawed_teams[guest_position-1]
    return home, guest
  end

  def undrawed_teams
    cup.winning_teams_at(matchday) - cup.drawed_teams_at(matchday)
  end

  def random_until(size, ignore=nil)
    number = Random.new.rand(1..size)
    number == ignore ? random_until(size, ignore) : number
  end

end
