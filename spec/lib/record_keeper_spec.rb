require 'record_keeper'

describe RecordKeeper do
  before do
    file = File.new("files/comma.txt", "w+")
    CSV.open(file, "w+") do |csv|
      csv << ["Dekker", "Desmond", "7-16-1941", "pink"]
      csv << ["Griffiths", "Marcia", "11-23-1949", "orange"]
      csv << ["Donaldson", "Eric", "6-11-1947", "beige"]
    end

    file = File.new("files/colon.txt", "w+")
    CSV.open(file, "w+", { col_sep: ";" }) do |csv| 
      csv << ["Mowatt", "Judy", "1-1-1952", "violet"]
      csv << ["Wailer", "Bunny", "4-10-1947", "auburn"]
      csv << ["Marley", "Rita", "7-25-1946", "saphire"]
    end
  end

  after(:context) do
    File.delete "files/comma.txt"
    File.delete "files/colon.txt"
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

  describe "after hook" do
    it "doesn't exist" do
      file = "files/test.txt"

      expect(File.exists?(file)).to eq false
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
  end

  describe ".order_records" do
    it "sorts the rows by column value" do
      keeper = RecordKeeper.new("test.txt")

      keeper.load("comma.txt")

      keeper.order_records(1, true)

      expect(keeper.records[2][1]).to eq "Desmond"
    end

    it "sorts the rows by date" do
      keeper = RecordKeeper.new("test.txt")

      keeper.load("comma.txt")

      keeper.order_records(2, true)

      expect(keeper.records[2][1]).to eq "Marcia"
    end
  end
end
