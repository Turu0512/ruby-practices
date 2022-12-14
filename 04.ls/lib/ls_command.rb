# frozen_string_literal: true

class LsCommand
  COLUMN = 3
  def initialize
    @current_directory = Dir.getwd
  end

  def run
    files = make_list
    screen_list = list_to_show(files)
    screen_in_the_directory(screen_list, files)
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
    max_rows = max_rows(files)
    Array.new(COLUMN) do |i|
      files.slice(max_rows * i, max_rows)
    end
  end

  def screen_in_the_directory(list, files)
    # 一番長い文字列のsizeを取得
    spacing_between_files = spacing_between_files(list)
    max_rows = max_rows(files)
    # 配列の長さを揃えて、transposeする
    align_list_length = list.each do |item|
      item.size < max_rows ? item.push(nil) : item
    end.transpose
    # 空白を追加してjoinする
    output_files_list = align_list_length.map do |array|
      array.map do |file1|
        file1&.ljust(spacing_between_files)
      end.join
    end
    puts output_files_list
  end

  def max_rows(files)
    # 列の数を指定する
    max_rows, mod = files.size.divmod(COLUMN)
    max_rows += 1 unless mod.zero?
    max_rows
  end

  def spacing_between_files(list)
    # 出力したファイル名の間隔を決定する
    spacing_between_files = 1
    list.each do |item|
      spacing_between_files = item.max_by(&:size).size + 3 if item.max_by(&:size).size >= max_file_name_len
    end
    spacing_between_files
  end

end

LsCommand.new.run
