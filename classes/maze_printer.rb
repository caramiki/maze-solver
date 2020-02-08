class MazePrinter
  def self.print_out(maze)
    maze.cells.each_with_index do |cell, i|
      print "\n" if i % 8 == 0 && i != 0
      print "#{self.colors[cell.value]}██\e[0m"
    end

    print "\n\n"
  end

  private

  def self.colors
    [
      "\e[30m", # black
      "\e[97m", # white
      "\e[96m", # light cyan
      "\e[34m", # blue
      "\e[92m"  # light green
    ]
  end
end
