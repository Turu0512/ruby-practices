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
  end

end

LsCommand.run
