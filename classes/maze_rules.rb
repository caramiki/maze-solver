# The table of instructions
# This could theoretically be represented as a finite list of conditions
class MazeRules
  def self.apply(solver, maze)
    current_cell = maze.cells[solver.current_cell]
    puts "\ncurrent cell: #{solver.current_cell}"
    puts "\nremaining moves: #{solver.remaining_moves}"

    # Negative remaining moves means moving left
    if solver.remaining_moves < 0
      puts "move left"
      solver.move_left
    # Positive remaining moves means moving right
    elsif solver.remaining_moves > 0
      puts "move right"
      solver.move_right
    elsif outside?(current_cell)
      puts "outside!"
      solver.solved = true
    elsif impassable?(current_cell)
      puts "cell is impassable"
      solver.retrace_steps(current_cell)
    else
      # Write info about the last-visited cell in the current cell.
      # e.g. if the last-visited cell was to the north and it was impassable,
      # add { north: 0 } to our cell hash.
      #
      # There are a finite number of combinations of directions and values, so we could theoretically
      # still represent the cell content with a "symbol" to follow the Turing machine limitations.
      puts "write came_from to current cell"
      solver.write(current_cell, solver.came_from)

      if unexplored?(current_cell)
        puts "current cell is unexplored, marking as explored"
        solver.write(current_cell, { value: Maze::EXPLORED })
      end

      unexplored_directions = current_cell.unexplored_directions

      if unexplored_directions.any?
        puts "set destination to #{unexplored_directions.first}"
        solver.set_destination(unexplored_directions.first, current_cell)
      else
        puts "dead end, setting destination #{current_cell.explored_directions.first}"
        # If we're in a cell that has no unexplored directions, we must have hit a dead-end, so we
        # need to go back to an explored cell and check for unexplored directions there
        solver.write(current_cell, { value: Maze::DEAD_END })
        solver.set_destination(current_cell.explored_directions.first, current_cell)
      end
    end
  end

  private

  def self.impassable?(cell, direction = :value)
    cell.send(direction) == Maze::IMPASSABLE
  end

  def self.unexplored?(cell, direction = :value)
    cell.send(direction) == Maze::UNEXPLORED
  end

  def self.explored?(cell, direction = :value)
    cell.send(direction) == Maze::EXPLORED
  end

  def self.dead_end?(cell, direction = :value)
    cell.send(direction) == Maze::DEAD_END
  end

  def self.outside?(cell)
    cell.value == Maze::OUTSIDE
  end
end
