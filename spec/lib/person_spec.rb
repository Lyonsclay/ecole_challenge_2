require 'person'
include Person

describe Person do
  let(:row_a) { %w(Griffiths Marcia Female orange 11/23/1949) } 
  let(:row_b) {  %w(Wailer Bunny G M 4-10-1952 violet) }

  describe "#parse" do
    it "orders the columns" do
      expect(Person.parse(row_a)).to eq %w(Griffiths Marcia Female 11/23/1949 orange)
    end

    it "removes extra column" do
      expect(Person.parse(row_b)).to eq %w(Wailer Bunny Male 4-10-1952 violet)
    end
  end
end
