require 'rails_helper'

RSpec.describe "create subscription", type: :request do
  describe "When a user sends a request to create a subscription," do
    it "returns a succesful response if params are correct and the subscription was created" do
      customer = Customer.create!(first_name: "Paul", last_name: "Leonard", email: "paul@gmail.com", address: "123 address")
      tea      = Tea.create!(title: "Paul Tea", description: "very good", temperature: 100, brew_time: 30)

      subscription_params = {
      subscription: {
        customer_id: customer.id,
        tea_id: tea.id,
        title: tea.title,
        price: 5.35,
        status: 'active',
        frequency: 'monthly'
     }}.to_json
    end
  end
end
