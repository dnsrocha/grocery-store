require 'csv'

class Customer

  attr_reader :id
  attr_accessor :email, :address

  def initialize(id, email, address)
    @id = id
    @email = email
    @address = address
  end

  def self.all
    customers = []
    CSV.read('data/customers.csv').each do |row|
      address = {
          street: row[2],
          city: row[3],
          state: row[4],
          zipcode: "#{row[5]}"
      }

      customer_info = self.new(row[0].to_i, row[1], address)
      customers << customer_info
    end
    return customers
  end

  def self.find(id)
    all_customers = self.all
    all_customers.each do |customer|
      if id == customer.id
        return customer
      end
    end
    return nil
  end

#   #wave 3 (optional)
  def self.save(filename, new_customer)

    new_customers = CSV.open(filename, "a+") #creates file
    new_customers << [new_customer.id, new_customer.email, new_customer.address[:street], new_customer.address[:city], new_customer.address[:state], new_customer.address[:zipcode]]

    return true
end

end

