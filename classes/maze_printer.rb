class MazePrinter
  COLORS = [
    "\e[30m", # black
    "\e[97m", # white
    "\e[96m", # light cyan
    "\e[34m", # blue
    "\e[92m"  # light green
  ]

  CURRENT_CELL_COLOR = "\e[31m" # red

  def self.print_out(maze, current_cell_index = nil)
    maze.cells.each_with_index do |cell, i|
      print "\n" if i % 8 == 0 && i != 0
      color = current_cell_index == i ? CURRENT_CELL_COLOR : COLORS[cell.value]
      print "#{color}██\e[0m"
    end

    print "\n\n"
  end
end
