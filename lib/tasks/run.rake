namespace :simple_app do
  desc 'run test'
  task :run => :environment do
   @start = Time.now
    run
  end

  def run
    Season.order(:year).last.teardown!
    puts "Season: ", Season.order(:year).last.year
    puts "-"*120
    puts "Ereignisse: #{Appointment.all.size}"
    puts ""
    puts "########### #{Time.now-@start} ###########"
    get_and_perform
    run
  end


  # def perform_appointments
  #   return false unless get_and_perform
  #   perform_appointments
  # end

  def get_and_perform
    appointment = Appointment.order(:appointed_at).first
    # puts "get and perform: appointment # #{appointment.try(:id)}"
    # puts "---------- #{Time.now-@start} ----------"
    return false unless appointment
    puts "Appointment: #{appointment.appointable.performed_at}"
    puts "matchday id: #{appointment.appointable.matchday.number}"
    puts "competition: #{appointment.appointable.matchday.competition.name}"
    perform appointment
    get_and_perform
  end

  def perform(appointment)
    # puts "perform: appointment # #{appointment.id}"
    # puts "++++++++++ #{Time.now-@start} ++++++++++"
    return false unless appointment
    # puts "---> appointable: #{appointment.appointable.class.name}"
    return false unless appointment.appointable.perform!
    perform appointment
  end
end
