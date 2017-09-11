## Particle Simulation

Simulates the effect of gravity on rocks and tables in a 2D pit, expressed by:
"." a single rock
":" two rocks, maximum capacity for each 2D cell
" " empty space that rocks can fall through
"T" a table which can not be moved, and which rocks can not fall through

Example Input:
<width> <height>                        # refer to example_input.txt
<simulation map>

## Usage:
./run_simulation                        # if you want to enter manually
./run_simulation example_input.txt      # if your data is already in a text file

## Testing:
ruby simulation_test.rb
