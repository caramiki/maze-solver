# A cell of the tape
class MazeCell
  # There are a finite number of combinations of directions and values, so we could theoretically
  # still represent the cell content with a "symbol" to follow the Turing machine limitations.
  attr_accessor :east, :west, :south, :north, :value

  def initialize(value)
    @value = value
    @east = Maze::UNEXPLORED
    @west = Maze::UNEXPLORED
    @south = Maze::UNEXPLORED
    @north = Maze::UNEXPLORED
  end

  # @return [Hash]
  def attrs
    directions.merge({ value: value })
  end

  # @return [Hash]
  def directions
    {
      east: east,
      west: west,
      south: south,
      north: north
    }
  end

  # @return [Symbol]
  def explored_direction
    directions.select { |_, v| v == Maze::EXPLORED }.keys.first
  end

  def impassable?(direction = :value)
    send(direction) == Maze::IMPASSABLE
  end

  def unexplored?(direction = :value)
    send(direction) == Maze::UNEXPLORED
  end

  def explored?(direction = :value)
    send(direction) == Maze::EXPLORED
  end

  def dead_end?(direction = :value)
    send(direction) == Maze::DEAD_END
  end

  def outside?
    value == Maze::OUTSIDE
  end
end
