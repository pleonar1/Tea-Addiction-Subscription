require 'rails_helper'

RSpec.describe "get subscriptions", type: :request do
  describe "When a User sends a request to get all of a customer's subscriptions," do
    it "returns all of a customers subscriptions even if they are active or cancelled" do
      customer      = Customer.create!(first_name: "Paul", last_name: "Leonard", email: "paul@gmail.com", address: "123 address")
      tea           = Tea.create!(title: "Paul Tea", description: "very good", temperature: 100, brew_time: 30)
      tea2          = Tea.create!(title: "Paul Tea2", description: "very good", temperature: 100, brew_time: 30)
      tea3          = Tea.create!(title: "Paul Tea3", description: "very good", temperature: 100, brew_time: 30)
      tea4          = Tea.create!(title: "Paul Tea4", description: "very good", temperature: 100, brew_time: 30)
      subscription  = customer.subscriptions.create!(title: "Sub Title", price: 9.89, status: 'active', frequency: 'monthly', tea_id: tea.id)
      subscription2 = customer.subscriptions.create!(title: "Sub Title2", price: 9.89, status: 'active', frequency: 'monthly', tea_id: tea2.id)
      subscription3 = customer.subscriptions.create!(title: "Sub Title3", price: 9.89, status: 'active', frequency: 'monthly', tea_id: tea3.id)
      subscription4 = customer.subscriptions.create!(title: "Sub Title4", price: 9.89, status: 'cancelled', frequency: 'monthly', tea_id: tea4.id)

      customer2      = Customer.create!(first_name: "Paul2", last_name: "Leonard2", email: "paul@g2mail.com", address: "122223 address")
      tea5           = Tea.create!(title: "Paul Tea5", description: "very good5", temperature: 1005, brew_time: 305)
      subscription5  = customer2.subscriptions.create!(title: "Sub Title5", price: 9.859, status: 'cancelled', frequency: 'monthly', tea_id: tea5.id)


      get "/api/v1/customers/#{customer.id}/subscriptions"

      expect(response).to be_successful

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data).to be_a Hash
      expect(data[:data]).to be_a Array
      expect(data[:data].length).to eq(4)
    end
  end
end
