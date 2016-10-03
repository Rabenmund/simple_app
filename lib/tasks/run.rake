namespace :simple_app do
  desc 'run test'
  task :run => :environment do
   @start = Time.now
    run
  end

  def run
    # Season.order(:year).last.teardown!
    puts "Season: ", Season.order(:year).last.year
    puts "-"*120
    puts "Ereignisse: #{SeasonEvent.all.size}"
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
    puts "get and perform: appointment # #{appointment.try(:id)}"
    puts "---------- #{Time.now-@start} ----------"
    return false unless appointment
    puts "Date: #{appointment.appointed_at}"
    puts "Type: #{appointment.appointable.eventable_type}"
    puts "matchday: #{appointment.appointable.eventable.try(:matchday).try(:name)}"
    puts "competition: #{appointment.appointable.eventable.try(:competition).try(:name)}: #{appointment.appointable.eventable.try(:name)}"
    perform appointment
    get_and_perform
  end

  def perform(appointment)
    puts "perform: appointment # #{appointment.id}"
    puts "-> #{appointment.appointable.eventable.season_event.inspect}"
    puts "++++++++++ #{Time.now-@start} ++++++++++"
    appointment.appointable.perform
    appointment.delete
    puts "********** #{Time.now-@start} **********"
  end
end
