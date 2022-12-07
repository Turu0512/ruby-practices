class LsCommand
  def initialize()
      @current_directory = Dir.getwd
  end
  
  def self.run
    ls = new
    ls.check_current_directory
  end

  def check_current_directory
    puts @current_directory
    screen_in_the_directory
  end

  def screen_in_the_directory
    Dir.foreach(@current_directory) do |item|
      next if item == '.' or item == '..'
      puts item
    end
  end

end

LsCommand.run
