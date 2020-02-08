# state = {
#   came_from: {
#     direction: :impassable || :unexplored || :explored || :dead_end
#   },
#   remaining_moves: "some int -8 thru 8",
#   solved: boolean
# }

# The Turing machine
class MazeSolver
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

  # Move the head left (a lower index in our cell array).
  # If we are moving left, our remaining moves must be negative, so add 1 so we get closer
  # to zero remaining moves.
  def move_left
    self.current_cell -= 1
    self.remaining_moves += 1
  end

  # Move the head right (a higher index in our cell array).
  # If we are moving right, our remaining moves must be positive, so subtract 1 so we get closer
  # to zero remaining moves.
  def move_right
    self.current_cell += 1
    self.remaining_moves -= 1
  end

  def retrace_steps(cell)
    puts "going back #{came_from.keys.first}"
    set_destination(came_from.keys.first, cell)
  end

  def set_destination(direction, cell)
    self.came_from = { "#{opposite_direction(direction)}": cell.value }

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
      puts "update cell's #{key} to #{value}"
    end
  end

  private

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
end
