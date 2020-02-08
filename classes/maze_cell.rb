# cell = {
#   north: :impassable || :unexplored || :explored || :dead_end,
#   south: :impassable || :unexplored || :explored || :dead_end,
#   east:  :impassable || :unexplored || :explored || :dead_end,
#   west:  :impassable || :unexplored || :explored || :dead_end,
#   value: :impassable || :unexplored || :explored || :dead_end || :outside
# }

# A cell of the tape
class MazeCell
  attr_accessor :north, :south, :east, :west, :value

  def initialize(value)
    @value = value
    @north = Maze::UNEXPLORED
    @south = Maze::UNEXPLORED
    @east = Maze::UNEXPLORED
    @west = Maze::UNEXPLORED
  end

  # @return [Hash]
  def attrs
    directions.merge({ value: value })
  end

  # @return [Hash]
  def directions
    {
      north: north,
      south: south,
      east: east,
      west: west
    }
  end

  # @return [Array] array of direction symbols
  def explored_directions
    directions.select { |_, v| v == Maze::EXPLORED }.keys
  end

  # @return [Array] array of direction symbols
  def unexplored_directions
    directions.select { |_, v| v == Maze::UNEXPLORED }.keys
  end
end
