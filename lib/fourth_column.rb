require 'csv'
require 'biz_card'

include BizCard

module FourthColumn

  def write_to_file(file_in, file_out)
    output = CSV.open(file_out, 'w')
    output << ['address']

    CSV.foreach(file_in) do |row| 
      next if row[0] == 'first_name'

      begin
        BizCard.parse(row)

        output << [row[3]]
      rescue => e
        p e, row
      end
    end

    output.close
  end
end

