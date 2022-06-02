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
      expect(response).to have_http_status(200)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to be_a Hash

      expect(data).to have_key(:data)
      expect(data[:data]).to have_key(:id)
      expect(data[:data]).to have_key(:type)
      expect(data[:data][:type]).to eq("subscription")
      expect(data[:data]).to have_key(:attributes)

      expect(data[:data][:attributes]).to be_a Hash
      expect(data[:data][:attributes]).to have_key(:subscription_id)
      expect(data[:data][:attributes][:subscription_id]).to eq(Subscription.last.id)
      expect(data[:data][:attributes]).to have_key(:title)
      expect(data[:data][:attributes][:title]).to eq("Paul Tea")
      expect(data[:data][:attributes][:title]).to be_a String
      expect(data[:data][:attributes]).to have_key(:price)
      expect(data[:data][:attributes][:price]).to be_a Float
      expect(data[:data][:attributes][:price]).to eq(9.89)
      expect(data[:data][:attributes]).to have_key(:status)
      expect(data[:data][:attributes][:status]).to be_a String
      expect(data[:data][:attributes][:status]).to eq("active")
      expect(data[:data][:attributes]).to have_key(:frequency)
      expect(data[:data][:attributes][:frequency]).to be_a String
      expect(data[:data][:attributes][:frequency]).to eq("monthly")
      expect(data[:data][:attributes]).to have_key(:tea_id)
      expect(data[:data][:attributes][:tea_id]).to eq(tea.id)
      expect(data[:data][:attributes][:tea_id]).to be_a Integer
      expect(data[:data][:attributes]).to have_key(:customer_id)
      expect(data[:data][:attributes][:customer_id]).to eq(customer.id)
      expect(data[:data][:attributes][:customer_id]).to be_a Integer
    end
  end
end
