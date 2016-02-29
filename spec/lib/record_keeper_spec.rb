require 'record_keeper'

describe ".append" do
  it "adds records to a file" do
    io = File.readlines("./lib/pipe_delimiter.txt")
    
    expect(io).to eq([])
  end

  it "does nothing" do
    expect(file.path).to eq([])
  end
end
