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
        price: 9.89,
        status: 'active',
        frequency: 'monthly'
                            }}.to_json
      headers = { 'CONTENT_TYPE' => 'application/json' }

      post "/api/v1/customers/#{customer.id}/subscriptions", headers: headers, params: subscription_params

      expect(response).to be_successful
      expect(response).to have_http_status(204)

      data = JSON.parse(response.body, symbolize_names: true)

      require "pry"; binding.pry
    end
  end
end
