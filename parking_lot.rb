require 'pry'
@available_space = []
@parking_lot = {}

def parking_lot
	if ARGV.count != 0
		file = File.read(ARGV[0])
		file.each_line.each do |line|
			input = line.split(' ')
			execute input unless input.empty?
		end
	else
		loop do
			input = gets.chomp.split(' ')
			execute input unless input.empty?
		end
	end
end

def execute input
	case input[0]
	when 'create_parking_lot'
		@available_space = (1..input[1].to_i).to_a
		puts "Created a parking lot with #{input[1]} slots"
	when 'park'
		if @available_space.count == 0
			puts 'Sorry, parking lot is full'
		else
			puts "Allocated slot number: #{@available_space.min}"
			@parking_lot[@available_space.min] = [input[1], input[2]]
			@available_space -= [@available_space.min]
		end
	when 'leave'
		slot_number = input[1].to_i
		puts "Slot number #{slot_number} is free"
		@parking_lot.delete(slot_number)
		@available_space << slot_number
	when 'status'
		puts "Slot No. \tRegistration No \tColour"
		@parking_lot.map{|key, value| puts "#{key} \t\t #{value[0]} \t\t #{value[1]}"}
	when 'registration_numbers_for_cars_with_colour'
		puts @parking_lot.values.group_by{|license, color| color}[input[1]].map(&:first).join(' ')
	when 'slot_numbers_for_cars_with_colour'
		puts @parking_lot.select{|k,j| j[1] == input[1]}.keys.join(' ')
	when 'slot_number_for_registration_number'
		puts @parking_lot.select{|k,j| j[0] == input[1]}.keys.first || 'Not Found'
	else
	  puts "You gave me #{input} -- I have no idea what to do with that."
	end
	puts
end

parking_lot