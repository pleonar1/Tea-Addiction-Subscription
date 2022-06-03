class Api::V1::SubscriptionsController < ApplicationController

  def index
    render json: SubscriptionSerializer.new(all_subscriptions)
  end

  def create
    subscription = Subscription.new(subscription_params)
    if subscription.save
      render json: SubscriptionSerializer.show_new_subscription(subscription)
    else
      render json: {error: "Subscription Could Not Be Saved"}, status: 402
    end
  end

  def update
    require "pry"; binding.pry
    subscription = Subscription.find(params[:id])
  #^this will error out so change it
    if valid_update_params?
      subscription.update_attribute(:status, 1)
      render json: SubscriptionSerializer.updated_status(subscription)
    else
      render json: {error: "Invalid credentials"}, status: 400
    end
  end


    private

    def subscription_params
      params.require(:subscription).permit(:customer_id, :tea_id, :title, :price, :status, :frequency)
    end

    def valid_update_params?
      params[:status] == 1 || params[:status] == 'cancelled'
    end

    def all_subscriptions
      Customer.find(params[:customer_id]).subscriptions
    end
end
