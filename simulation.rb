#!/usr/bin/ruby

class Simulation
    def initialize()
    end

    def input()
        @pit = []

        ARGF.each_with_index do |line, i|
            if i == 0
                @pit_width, @pit_height = line.split(' ').map{ |dimensions| dimensions.to_i }
            else
                @pit += [line.chomp.chars]
            end
        end
    end

    def validate_input()
        if !@pit_width.kind_of?(Integer) || @pit_width < 1
           !@pit_height.kind_of?(Integer) || @pit_height < 1
            raise "Invalid dimensions supplied."
        end

        if @pit.size != @pit_height ||
           @pit.select{ |level| level.size != @pit_width }.size > 0
            raise "Simulation map does not match supplied dimensions."
        end

        if @pit.flatten.select{ |cell| !' .:T'.include? cell }.size > 0
            raise "Simulation map contains invalid characters."
        end
    end

    def self.gravity_sort(stack)
        # HACK splitting string to sort, then joining may not be the best way?
        sorted_stack = stack.chars.sort.join
        collapsed_stack = sorted_stack.gsub(/\.\./, " :")
        resorted_stack = collapsed_stack.chars.sort.join

        return resorted_stack
    end

    def self.split_stack_sort(row)
        stacks = []

        row.split('T', -1).each do |stack|
            stacks += [Simulation.gravity_sort(stack)]
        end

        return stacks.join('T')
    end

    def simulate()
        validate_input()

        transposed_end_pit = []

        @pit.transpose.each do |row|
            transposed_end_pit += [Simulation.split_stack_sort(row.join).chars]
        end

        @end_pit = transposed_end_pit.transpose
    end

    def output()
        @end_pit.each { |level| puts level.join }
    end
end

