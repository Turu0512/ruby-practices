# frozen_string_literal: true

class LsCommand
  COLUMN = 3
  def initialize
    @current_directory = Dir.getwd
  end

  def run
    files = make_list
    screen_list = list_to_show(files)
    screen_in_the_directory(screen_list)
  end

  def make_list
    files = []
    Dir.foreach(@current_directory) do |item|
      next if item.start_with?('.', '..')

      files.push(item)
    end
    files.sort
  end

  def list_to_show(files)
    # 列の数を指定する。
    max_rows, mod = files.size.divmod(COLUMN)
    max_rows += 1 if mod.zero?

    Array.new(COLUMN) do |i|
      files.slice(max_rows * i, max_rows)
    end
  end

  def screen_in_the_directory(list)
    # 一番長い文字列のsizeを取得
    max_file_name_len = 1
    list.each do |files|
      max_file_name_len = files.max_by(&:size).size if files.max_by(&:size).size >= max_file_name_len
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
