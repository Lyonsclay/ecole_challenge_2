module Person
  Person = Struct.new(:last_name, :first_name, :gender, :dob, :color)

  def parse(row)
    row.delete_at(2) if row.count == 6

    person = Person.new(row[0], row[1])
    
    row[2, 4].each do |col|
      if /^M/.match(col)
        person[:gender] = "Male"
      elsif /^F/.match(col)
        person[:gender] = "Female"
      elsif /^\d/.match(col)
        person[:dob] = col
      else
        person[:color] = col
      end
    end

    person.values
  end
end
