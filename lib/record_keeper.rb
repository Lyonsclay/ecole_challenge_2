require 'csv'
require 'date'
require 'person'

include Person

CSV::Converters[:date_slash] = lambda { |col|
  s = /\d*\//.match(col) ? "/" : "-"
  begin
   date = Date.strptime(col, "%m#{s}%d#{s}%Y")
   date.strftime("%-m/%-d/%Y")
  rescue
    col
  end }

class RecordKeeper
  attr_reader :records

  def initialize(file)
    @file = File.new("files/" + file, "w+")
    @records = []
  end

  def load(file, separator = ", ")
    file = File.absolute_path("files/" + file)

    options = { col_sep: separator, converters: :date_slash }

    CSV.foreach(file, options) do |row| 
      @records << Person.parse(row)
    end
  end

  def order_records(col, reverse = false)
    n = 0

    if col == 3
      @records.sort_by! { |i| n+= 1; [Date.strptime(i[col], "%m/%d/%Y"), n] }
    else
      @records.sort_by! { |i| n+= 1; [i[col], n] }
    end

    @records.reverse! if reverse == true
  end

  def write_to_file
    CSV.open(@file, 'w+', { col_sep: " " }) do |csv| 
      @records.each do |record| 
        csv << record
      end
    end
  end
end

