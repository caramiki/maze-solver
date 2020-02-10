# state = {
#   came_from: {
#     direction: :impassable || :unexplored || :explored || :dead_end
#   },
#   remaining_moves: "some int -8 thru 8",
#   solved: boolean
# }

# The Turing machine
class MazeSolver
  include DebugMode

  # came_from, remaining_moves, and solved are part of the "state" of our Turing machine
  # All of these state attributes have a finite number of values.
  #
  # current_cell indicates where the "head" of our Turing machine is on the "tape".
  attr_accessor :came_from, :remaining_moves, :solved, :current_cell

  def initialize(args)
    @came_from = args[:came_from]
    @remaining_moves = args[:remaining_moves]
    @solved = args[:solved]
    @current_cell = args[:current_cell]
  end

  def came_from_direction
    came_from.keys.first
  end

  def came_from_value
    came_from.values.first
  end

  def facing
    opposite_direction(came_from_direction)
  end

  # Move the head left (a lower index in our cell array).
  # If we are moving left, our remaining moves must be negative, so add 1 so we get closer
  # to zero remaining moves.
  def move_left
    puts_if_debug_mode "move left"
    self.current_cell -= 1
    self.remaining_moves += 1
  end

  # Move the head right (a higher index in our cell array).
  # If we are moving right, our remaining moves must be positive, so subtract 1 so we get closer
  # to zero remaining moves.
  def move_right
    puts_if_debug_mode "move right"
    self.current_cell += 1
    self.remaining_moves -= 1
  end

  def set_destination(direction, cell)
    puts_if_debug_mode "set destination to #{direction}"
    self.came_from = { "#{opposite_direction(direction)}": cell.value }

    # Tentatively mark the direction we're going in as "explored".
    # If we're wrong, we'll be coming back to this cell later anyway and
    # we'll correct it then.
    write(cell, { "#{direction}": Maze::EXPLORED })

    case direction
    when :east
      self.remaining_moves = 1
    when :west
      self.remaining_moves = -1
    when :south
      self.remaining_moves = 8
    when :north
      self.remaining_moves = -8
    end
  end

  def write(cell, attrs)
    attrs.each do |key, value|
      cell.send("#{key}=", value)
      puts_if_debug_mode "update cell's #{key} to #{value}"
    end
  end

  # Get the direction to the left of whatever direction we're facing.
  # @return [Symbol]
  def left
    opposite_direction(right)
  end

  def opposite_direction(direction)
    case direction
    when :east
      :west
    when :west
      :east
    when :south
      :north
    when :north
      :south
    end
  end

  # Get the direction to the right of whatever direction we're facing.
  # @return [Symbol]
  def right
    case facing
    when :east
      :south
    when :west
      :north
    when :south
      :west
    when :north
      :east
    end
  end
end
