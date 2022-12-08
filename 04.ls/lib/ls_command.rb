class LsCommand
  def initialize()
    @current_directory = Dir.getwd
    @files = Array.new
  end
  
  def run
    files = get_list
    screen_list = list_to_show(files)
  end

  def get_list
    Dir.foreach(@current_directory) do |item|
      next if item == '.' or item == '..'
      @files.push(item)
    end
    @files.sort!
  end

  def list_to_show(files)
    # 列の数を指定する。
    columuns = 3
    max_rows = if files.size % columuns == 0
      files.size / columuns
    else
        (files.size / columuns) + 1
    end

    split_files = columuns.times.map do |i|
      if i.zero?
        files.slice(0, max_rows)
      else
        files.slice((max_rows) * i,max_rows)
      end
    end
  end

    end
  end

end

LsCommand.new.run
