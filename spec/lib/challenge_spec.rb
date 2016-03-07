require 'record_keeper'

describe "Challenge 2" do
  let(:keeper) { RecordKeeper.new("challenge.txt") }

  let(:output_1) {
    """Hingis Martina Female 4/2/1979 Green
Kelly Sue Female 7/12/1959 Pink
Kournikova Anna Female 6/3/1975 Red
Seles Monica Female 12/2/1973 Black
Abercrombie Neil Male 2/13/1943 Tan
Bishop Timothy Male 4/23/1967 Yellow
Bonk Radek Male 6/3/1975 Green
Bouillon Francis Male 6/3/1975 Blue
Smith Steve Male 3/3/1985 Red
"""}

  let(:output_2) {
    """Abercrombie Neil Male 2/13/1943 Tan
Kelly Sue Female 7/12/1959 Pink
Bishop Timothy Male 4/23/1967 Yellow
Seles Monica Female 12/2/1973 Black
Bonk Radek Male 6/3/1975 Green
Bouillon Francis Male 6/3/1975 Blue
Kournikova Anna Female 6/3/1975 Red
Hingis Martina Female 4/2/1979 Green
Smith Steve Male 3/3/1985 Red
"""}

  let(:output_3) {
    """Smith Steve Male 3/3/1985 Red
Seles Monica Female 12/2/1973 Black
Kournikova Anna Female 6/3/1975 Red
Kelly Sue Female 7/12/1959 Pink
Hingis Martina Female 4/2/1979 Green
Bouillon Francis Male 6/3/1975 Blue
Bonk Radek Male 6/3/1975 Green
Bishop Timothy Male 4/23/1967 Yellow
Abercrombie Neil Male 2/13/1943 Tan
"""}

  before(:example) do
    keeper.load("coma_delimited.txt", ", ")
    keeper.load("space_delimited.txt", " ")
    keeper.load("pipe_delimited.txt", " | ")
  end

  after(:context) do
    File.delete "files/challenge.txt"
  end

  it "sorts by gender and last name" do
    keeper.order_records(0)
    keeper.order_records(2)

    keeper.write_to_file

    file = File.open("files/challenge.txt", "rb")
    contents = file.read

    expect(contents).to eq output_1
  end

  it "sorts by last name and date" do
    keeper.order_records(0)
    keeper.order_records(3)

    keeper.write_to_file

    file = File.open("files/challenge.txt", "rb")
    contents = file.read

    expect(contents).to eq output_2
  end

  it "sorts by last name in reverse" do
    keeper.order_records(0, true)

    keeper.write_to_file

    file = File.open("files/challenge.txt", "rb")
    contents = file.read

    expect(contents).to eq output_3
  end
end
