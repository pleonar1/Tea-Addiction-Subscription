require 'rails_helper'

RSpec.describe "update subscription", type: :request do
  describe "When a user submits a request to update a subscriptions status," do
    it "returns a succesful response if params are correct and the subscription was updated" do
      customer     = Customer.create!(first_name: "Paul", last_name: "Leonard", email: "paul@gmail.com", address: "123 address")
      tea          = Tea.create!(title: "Paul Tea", description: "very good", temperature: 100, brew_time: 30)
      subscription = customer.subscriptions.create!(title: "Sub Title", price: 9.89, status: 'active', frequency: 'monthly', tea_id: tea.id)

      patch "/api/v1/customers/#{customer.id}/subscriptions/#{subscription.id}", params: {status: 'cancelled'}

      subscription.reload

      data = JSON.parse(response.body, symbolize_names: true)


      expect(response).to be_successful
      expect(response).to have_http_status(200)

      expect(data).to be_a Hash
      expect(data[:data]).to be_a Hash

      expect(data[:data][:type]).to be_a String
      expect(data[:data][:type]).to eq("subscription")

      expect(data[:data][:subscription_status]).to be_a String
      expect(data[:data][:subscription_status]).to eq("cancelled")

      expect(data[:data][:subscription_status]).to eq(subscription.status)
      expect(data[:data][:subscription_id]).to eq(subscription.id)
    end
  end
end
