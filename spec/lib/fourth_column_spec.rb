require 'csv'
require 'fourth_column'
include FourthColumn

describe FourthColumn do
  it "copies clean data" do
    @file_in = 'files/us-500.csv'
    @file_out = 'files/test.csv'

    File.write(@file_out, '')

    FourthColumn.write_to_file(@file_in, @file_out)

    input = CSV.read(@file_in)
    output = CSV.read(@file_out)

    expect(input.length).to eq output.length
    expect(input[1][3]).to eq output[1][0]
    expect(input.last[3]).to eq output.last[0]
  end

  it "doesn't copy dirty data" do
    @file_out = 'files/test.csv'
    @dirty = 'files/us-500-dirty.csv'

    File.write(@file_out, '')

    FourthColumn.write_to_file(@dirty, @file_out)

    dirty = CSV.read(@dirty)
    output = CSV.read(@file_out)

    expect(dirty.length - 10).to eq output.length
  end
end
