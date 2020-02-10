module DebugMode
  DEBUG_MODE = false
  
  def print_if_debug_mode(str)
    return unless DEBUG_MODE

    print str
  end

  def puts_if_debug_mode(str)
    return unless DEBUG_MODE

    puts str
  end
end
