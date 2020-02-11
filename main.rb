require './concerns/debug_mode'

require './classes/maze_solver'
require './classes/maze'
require './classes/maze_cell'
require './classes/maze_rules'
require './classes/maze_printer'

RUN_SPEED = 0.1

mazes = [
  {
    cells: [
      0, 0, 0, 0, 0, 0, 1, 0,
      0, 0, 0, 0, 0, 1, 1, 0,
      0, 0, 0, 0, 1, 1, 0, 0,
      0, 0, 0, 1, 1, 0, 0, 0,
      0, 0, 1, 1, 0, 0, 0, 0,
      0, 1, 1, 0, 0, 0, 0, 0,
      0, 1, 0, 0, 0, 0, 0, 0,
      0, 4, 0, 0, 0, 0, 0, 0
    ],
    starting_cell: 6,
    came_from: { north: Maze::IMPASSABLE }
  },
  {
    cells: [
      0, 1, 0, 0, 0, 0, 0, 0,
      0, 1, 0, 1, 1, 0, 1, 0,
      0, 1, 1, 1, 0, 0, 1, 0,
      0, 0, 0, 1, 1, 0, 1, 0,
      0, 1, 0, 0, 1, 0, 1, 0,
      0, 1, 1, 1, 1, 1, 1, 0,
      0, 0, 0, 0, 0, 0, 1, 0,
      0, 0, 0, 0, 0, 0, 4, 0
    ],
    starting_cell: 1,
    came_from: { north: Maze::IMPASSABLE }
  },
  {
    cells: [
      0, 0, 0, 0, 0, 0, 1, 0,
      0, 1, 1, 1, 1, 0, 1, 0,
      0, 0, 1, 0, 1, 1, 1, 0,
      0, 1, 1, 1, 0, 1, 0, 0,
      0, 1, 0, 1, 0, 1, 1, 0,
      0, 1, 1, 1, 0, 0, 0, 0,
      0, 1, 0, 1, 1, 1, 1, 4,
      0, 0, 0, 0, 0, 0, 0, 0
    ],
    starting_cell: 6,
    came_from: { north: Maze::IMPASSABLE }
  },
  {
    cells: [
      0, 0, 0, 0, 1, 0, 0, 0,
      0, 1, 1, 1, 1, 1, 1, 0,
      0, 1, 0, 1, 0, 0, 1, 0,
      0, 1, 1, 1, 1, 1, 1, 0,
      0, 1, 0, 0, 1, 0, 1, 0,
      0, 1, 1, 1, 1, 1, 1, 0,
      0, 1, 0, 1, 0, 0, 1, 0,
      0, 0, 0, 4, 0, 0, 0, 0
    ],
    starting_cell: 4,
    came_from: { north: Maze::IMPASSABLE }
  }
]

maze_num = nil

while !maze_num
  puts "Choose maze:"
  puts (1..mazes.length).to_a.join(" - ")
  maze_num = gets.chomp.to_i

  if maze_num < 0 || maze_num > mazes.length
    puts "Invalid choice."
    maze_num = nil
  end
end

maze_data = mazes[maze_num - 1]
maze = Maze.new(maze_data[:cells])
initial_maze = Maze.new(maze_data[:cells])

solver = MazeSolver.new(
  solved: false,
  remaining_moves: 0,
  came_from: maze_data[:came_from],
  current_cell: maze_data[:starting_cell]
)

while !solver.solved
  MazeRules.apply(solver, maze)
  MazePrinter.print_out(maze, solver.current_cell)
  sleep RUN_SPEED
end

puts "\nInitial Maze:"
MazePrinter.print_out(initial_maze)

puts "Solved:"
MazePrinter.print_out(maze)
