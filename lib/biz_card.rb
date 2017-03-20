require 'uri'

module BizCard
  Card = Struct.new(
    :last_name,
    :first_name,
    :business,
    :address,
    :city,
    :county,
    :state,
    :zip,
    :phone1,
    :phone2,
    :email,
    :url
  )

  CardChecks = {
    last_name: /\A[A-Z][a-z]*\z/,
    first_name: /\A[A-Z][a-z]*\z/,
    business: /\A[a-zA-Z, \d&]*\z/,
    address: /\A[a-zA-Z\d #]*\z/,
    city: /\A[A-Za-z ]*\z/,
    county:  /\A[A-Za-z \-]*\z/,
    state: /\A[A-Z][A-Z]\z/,
    zip: /\d{5}/,
    phone1: /\d{3}-\d{3}-\d{3}/,
    phone2: /\d{3}-\d{3}-\d{3}/,
    email: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
    url: /\A#{URI.regexp}\z/
  }

  def parse(row)
    card = Card.new(*row)

    card[:zip] = card[:zip].to_s

    Card.members.each do |col|
      raise "Bad data in column #{col}, #{card[col]}" unless card[col] =~ CardChecks[col]
    end
  end
end
