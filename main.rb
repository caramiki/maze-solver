require './classes/maze_solver'
require './classes/maze'
require './classes/maze_cell'
require './classes/maze_rules'
require './classes/maze_printer'

maze_data1 = {
  cells: [
    0, 0, 0, 0, 0, 0, 1, 0,
    0, 0, 0, 0, 0, 1, 1, 0,
    0, 0, 0, 0, 1, 1, 0, 0,
    0, 0, 0, 1, 1, 0, 0, 0,
    0, 0, 1, 1, 0, 0, 0, 0,
    0, 1, 1, 0, 0, 0, 0, 0,
    0, 1, 0, 0, 0, 0, 0, 0,
    0, 1, 0, 0, 0, 0, 0, 0,
    4, 4, 4, 4, 4, 4, 4, 4
  ],
  starting_cell: 6
}

maze_data2 = {
  cells: [
    0, 1, 0, 0, 0, 0, 0, 0,
    0, 1, 0, 1, 1, 0, 1, 0,
    0, 1, 1, 1, 0, 0, 1, 0,
    0, 0, 0, 1, 1, 0, 1, 0,
    0, 1, 0, 0, 1, 0, 1, 0,
    0, 1, 1, 1, 1, 1, 1, 0,
    0, 0, 0, 0, 0, 0, 1, 0,
    0, 0, 0, 0, 0, 0, 1, 0,
    4, 4, 4, 4, 4, 4, 4, 4
  ],
  starting_cell: 1
};

maze = Maze.new(maze_data2[:cells])
initial_maze = Maze.new(maze_data2[:cells])

solver = MazeSolver.new(
  solved: false,
  remaining_moves: 0,
  came_from: { north: Maze::IMPASSABLE },
  current_cell: maze_data2[:starting_cell]
)

while !solver.solved
  MazeRules.apply(solver, maze)
end

puts "\nInitial Maze:"
MazePrinter.print_out(initial_maze)

puts "Solved:"
MazePrinter.print_out(maze)
