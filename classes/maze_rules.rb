# The table of instructions
# This could theoretically be represented as a finite list of conditions
class MazeRules
  extend DebugMode

  def self.apply(solver, maze)
    current_cell = maze.cells[solver.current_cell]
    puts_if_debug_mode "\ncurrent cell: #{solver.current_cell}"
    puts_if_debug_mode "remaining moves: #{solver.remaining_moves}"

    # Negative remaining moves means moving left
    if solver.remaining_moves < 0
      solver.move_left
    # Positive remaining moves means moving right
    elsif solver.remaining_moves > 0
      solver.move_right
    elsif current_cell.outside?
      puts_if_debug_mode "outside!"
      solver.solved = true
    elsif current_cell.impassable?
      puts_if_debug_mode "cell is impassable"
      solver.set_destination(solver.came_from_direction, current_cell)
    else
      # Write info about the last-visited cell in the current cell.
      # e.g. if the last-visited cell was to the north and it was impassable,
      # set cell's north to 0.
      solver.write(current_cell, solver.came_from)

      if current_cell.unexplored?
        puts_if_debug_mode "current cell is unexplored, marking as explored"
        solver.write(current_cell, { value: Maze::EXPLORED })
      end

      next_direction = next_unexplored_direction(solver, current_cell)

      if next_direction
        solver.set_destination(next_direction, current_cell)
      else
        puts_if_debug_mode "current cell is a dead end"

        # If we're in a cell that has no unexplored directions, we must have hit a dead-end, so we
        # need to go back to an explored cell and check for unexplored directions there
        solver.write(current_cell, { value: Maze::DEAD_END })
        solver.set_destination(current_cell.explored_direction, current_cell)
      end
    end
  end

  private

  # We'll always try the direction to our right first, then forward, then left.
  # This guarantees we will never enter an endless loop.
  def self.next_unexplored_direction(solver, cell)
    if cell.unexplored?(solver.right)
      solver.right
    elsif cell.unexplored?(solver.facing)
      solver.facing
    elsif cell.unexplored?(solver.left)
      solver.left
    else
      nil
    end
  end
end
