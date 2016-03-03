require 'record_keeper'

describe RecordKeeper do
  before do
    file = File.new("files/comma.txt", "w+")
    CSV.open(file, "w+") do |csv|
      csv << ["Dekker", "Desmond", "7-16-1941", "pink"]
      csv << ["Griffiths", "Marcia", "11-23-1949", "orange"]
      csv << ["Donaldson", "Eric", "6-11-1947", "beige"]
    end

    file = File.new("files/pipe.txt", "w+")
    CSV.open(file, "w+", { col_sep: "|" }) do |csv| 
      csv << ["Mowatt", "Judy", "1-1-1952", "violet"]
      csv << ["Wailer", "Bunny", "4-10-1947", "auburn"]
      csv << ["Marley", "Rita", "7-25-1946", "saphire"]
    end
  end

  after(:context) do
    File.delete "files/comma.txt"
    File.delete "files/pipe.txt"
  end

  after(:example) do
    begin
      File.delete "files/test.txt"
    rescue
      # it's cool!
    end
  end

  describe ".initialize" do
    it "creates a new file" do
      keeper = RecordKeeper.new("test.txt")

      expect(keeper).to be_a RecordKeeper
    end
  end

  describe ".load" do
    it "loads row/columns into array" do
      keeper = RecordKeeper.new("test.txt")

      keeper.load("comma.txt")
      
      expect(keeper.records).to be_an Array
      expect(keeper.records[0].count).to eq 4
      expect(keeper.records[1][1]).to eq "Marcia"
    end

    it "loads multiple files" do
      keeper = RecordKeeper.new("test.txt")

      keeper.load("comma.txt")
      keeper.load("pipe.txt")
 
      expect(keeper.records.count).to eq 6
    end
  end

  describe ".order_records" do
    it "sorts the rows by column value" do
      keeper = RecordKeeper.new("test.txt")

      keeper.load("comma.txt")

      keeper.order_records(1)

      expect(keeper.records[0][1]).to eq "Desmond"
    end

    it "sorts the rows by date" do
      keeper = RecordKeeper.new("test.txt")

      keeper.load("comma.txt")

      keeper.order_records(2)

      expect(keeper.records[0][2]).to eq "11-23-1949"
    end

    it "sorts the rows in reverse" do
      keeper = RecordKeeper.new("test.txt")

      keeper.load("comma.txt")

      keeper.order_records(1, true)

      expect(keeper.records[2][1]).to eq "Desmond"
    end
  end

  describe ".write_to_file" do
    it "writes records to file" do
      keeper = RecordKeeper.new("test.txt")

      keeper.load("comma.txt")

      records = keeper.records
     
      keeper.write_to_file

      keeper.load("test.txt")

      expect(keeper.records[0]).to eq records[3]
    end
  end
end
