require 'json'

events =  Array.new


def event_gen(room_id)
	rm_events = Array.new #all events for the room
	event = Hash.new
	rm = room_id.to_i


	rand(0..5).times do 
    	start = rand(0..12) * 100 + 800
    	dur = rand(1..3) * 100
    	fin = start + dur
    	event = {room_id: rm, start_time: start.to_i, end_time: fin.to_i}
 		rm_events.push(event)
    end
	
	return rm_events.sort!{|a,b| a[:start_time] <=> b[:start_time]}
end
 
puts "Input room numbers seperated by spaces"
rooms = gets.chomp.split( " ").to_a

puts " Rooms are #{rooms}"

rooms.each do |rm|
	events.push(event_gen(rm))
end

puts "#{events.flatten!}"

#deletes entries where events clash in the same room
i = 0
until i == events.count - 1
	if (events[i][:room_id] == events[i + 1][:room_id]) && (events[i + 1][:start_time] < events[i][:end_time])
			events.delete_at(i + 1)
			puts "clashing event deleted!"
			redo
	end
	i += 1
end

puts events
puts "Name of file?"
file_name = gets.chomp + ".json"

File.open(file_name, "w") {|f| f.write(JSON.generate(events)) }
puts "File saved to #{file_name}"