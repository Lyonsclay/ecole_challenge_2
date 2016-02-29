class RecordKeeper
  def init(file)
    @file = file
  end

  def insert(file)
    record = parse(file)

    write_to_file
  end

  def parse(file)
    
  end
end
