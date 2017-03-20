require 'CSV'
require 'biz_card'
include BizCard

describe BizCard do
  let(:row_a) {
    [
      "James",
      "Butt",
      "Benton, John B Jr",
      "6649 N Blue Gum St",
      "New Orleans",
      "Orleans",
      "LA",
      70116,
      "504-621-8927",
      "504-845-1427",
      "jbutt@gmail.com",
      "http://www.bentonjohnbjr.com"
    ]
  }
  let(:row_b) {  %w(Wailer Bunny G M 4-10-1952 violet) }

  describe "#parse" do
    it "parses a clean row" do
      check = BizCard.parse(row_a)

      expect(check.count).to eq 12
    end

    it "parses a clean file" do
      CSV.foreach('files/us-500.csv') do |row|
        next if row[0] == 'first_name'
        begin
          BizCard.parse(row)
        rescue => e
          p e
        end
      end
    end
  end
end
