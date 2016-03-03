require 'csv'
require 'date'

class RecordKeeper
  attr_reader :records

  def initialize(file)
    @file = File.new("files/" + file, "w+")
    @records = []
  end

  def load(file, separator = ",")
    file = File.absolute_path("files/" + file)
    
    CSV.foreach(file, { col_sep: separator } ) do |row| 
      @records << row
    end
  end

  def order_records(col, reverse = false)
    begin
      Date.parse(@records[0][col])

      @records.sort! { |a, b| Date.parse(a[col]) <=> Date.parse(b[col]) }
    rescue
      @records.sort! { |a, b| a[col] <=> b[col] }

      @records.reverse! if reverse
    end
  end

  def write_to_file
    CSV.open(@file, "w+") do |csv| 
      @records.each do |record| 
        csv << record
      end
    end
  end
end

