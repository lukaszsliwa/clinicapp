require 'clockwork'
include Clockwork

handler do |job|
  puts "Running #{job}"
end
every(1.day, 'Patient.remind_if_not_finished', :at => '00:10')
