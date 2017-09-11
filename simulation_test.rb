require 'minitest/autorun'
require_relative 'simulation'

class TestSimulation < MiniTest::Unit::TestCase
    def test_valid_input
        sim = Simulation.new
        sim.instance_variable_set(:@pit_width, 4)
        sim.instance_variable_set(:@pit_height, 1)
        sim.instance_variable_set(:@pit, [[[' '],['.'],[':'],['T']]])

        sim.validate_input()
    end

    def test_invalid_input
        sim = Simulation.new
        sim.instance_variable_set(:@pit_width, 1)
        sim.instance_variable_set(:@pit_height, 1)
        sim.instance_variable_set(:@pit, [[['@']]])

        assert_raises RuntimeError do
            sim.validate_input()
        end
    end

    def test_gravity_sort
        # trivial cases
        assert_equal ' ', Simulation.gravity_sort(' ')
        assert_equal '.', Simulation.gravity_sort('.')
        assert_equal ':', Simulation.gravity_sort(':')
        assert_equal 'T', Simulation.gravity_sort('T')

        # test rocks settling
        assert_equal ' .', Simulation.gravity_sort('. ')
        assert_equal '  :', Simulation.gravity_sort('.. ')
        assert_equal '  :', Simulation.gravity_sort(':  ')

        # test table support
        assert_equal ' .T ', Simulation.split_stack_sort('. T ')
        assert_equal ' :T ', Simulation.split_stack_sort(': T ')
        assert_equal '  :T  ', Simulation.split_stack_sort('.. T  ')

        # complex case
        assert_equal 'T     ::T .:TT :', Simulation.split_stack_sort('T : . . T:. TT..')
    end

    def test_simulation
        sim = Simulation.new
        sim.instance_variable_set(:@pit_width, 7)
        sim.instance_variable_set(:@pit_height, 4)
        sim.instance_variable_set(:@pit, [[['.'],['.'],['.'],['.'],['.'],[':'],[':']],
                                          [['.'],['T'],[' '],[' '],[' '],[' '],[':']],
                                          [[' '],[' '],['.'],['T'],[' '],['.'],[':']],
                                          [[' '],[' '],['.'],[' '],[' '],[' '],[':']]])

        sim.simulate()

        assert_equal [[' ','.',' ',' ',' ',' ',':'],
                      [' ','T',' ','.',' ',' ',':'],
                      [' ',' ','.','T',' ','.',':'],
                      [':',' ',':',' ','.',':',':']],
            sim.instance_variable_get(:@end_pit)
    end
end
