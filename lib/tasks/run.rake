namespace :simple_app do
  desc 'run test'
  task :run => :environment do
    run
  end

  def run
    Season.order(:year).last.teardown!
    puts "Season: ", Season.order(:year).last
    puts "-"*120
    puts "Ereignisse: #{Appointment.all.size}"
    puts ""
    get_and_perform
    run
  end


  # def perform_appointments
  #   return false unless get_and_perform
  #   perform_appointments
  # end

  def get_and_perform
    appointment = Appointment.order(:appointed_at).first
    return false unless appointment
    puts "Appointment: #{appointment.appointable.performed_at}"
    puts appointment.appointable.matchday.number
    puts appointment.appointable.matchday.competition.name
    perform appointment
    get_and_perform
  end

  def perform(appointment)
    return false unless appointment
    return false unless appointment.appointable.perform!
    perform appointment
  end
end
