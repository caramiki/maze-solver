# The tape
class Maze
  attr_accessor :cells

  # Possible cell values

  # i.e. inside a wall
  IMPASSABLE = 0

  # A cell that we have not visited before.
  # Should immediately be changed to EXPLORED.
  UNEXPLORED = 1

  # A cell we have visited before.
  EXPLORED = 2

  # A cell that is a dead end or leads to a dead end.
  DEAD_END = 3

  # The outside of the maze.
  # We have successfully solved the maze if we reach a cell with a value of 4
  OUTSIDE = 4

  def initialize(arr)
    @cells = []
    arr.each { |cell| @cells << MazeCell.new(cell) }
  end
end
