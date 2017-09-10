#!/usr/bin/ruby

class Simulation
	def initialize()
		@pit_levels = []
		ARGF.each_with_index do |line, i|
			if i == 0
				@pit_width, @pit_height = line.split(' ').map{ |dimensions| dimensions.to_i }
			else
				@pit_levels += [line.chomp.chars]
			end
		end

		validate_input()
	end

	def validate_input()
	end

	def gravity_sort(stack)
		return stack.chars.sort.join.gsub(/\.\./, ' :').chars.sort.join
	end

	def simulate()
		transposed_start_pit = @pit_levels.transpose
		transposed_end_pit = []

		transposed_start_pit.each do |row|
			stacks = []

			row.join.split('T').each do |stack|
				stacks += [gravity_sort(stack)]
			end

			transposed_end_pit += [stacks.join('T').chars]
		end

		@end_pit = transposed_end_pit.transpose
	end

	def output()
		@end_pit.each { |line| puts line.join }
	end
end

