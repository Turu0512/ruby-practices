class LsCommand
  def initialize()
    @current_directory = Dir.getwd
    @files = Array.new
  end
  
  def run
    files = get_list
    screen_list = list_to_show(files)
    screen_in_the_directory(screen_list)
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

  def screen_in_the_directory(list)
    # 一番長い文字列のsizeを取得
    max_file_name_len = 1
    @files.each do |file|
      if file.size >= max_file_name_len
        max_file_name_len = file.size
      end
    end

    output_files_list = (0..list[0].size).map do |i|
      output_file = list.map do |file_array|
        file_array[i]&.ljust(max_file_name_len + 3)
      end
      output_file.join
    end
    puts output_files_list
  end

end

LsCommand.new.run
