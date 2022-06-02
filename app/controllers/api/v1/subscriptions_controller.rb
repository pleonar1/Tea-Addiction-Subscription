class Api::V1::SubscriptionsController < ApplicationController

  def create
    subscription = Subscription.new(subscription_params)
    if subscription.save
      render json: SubscriptionSerializer.show_new_subscription(subscription)
    else
      render json: {error: "Subscription Could Not Be Saved"}, status: 402
    end
  end

  def update
    subscription = Subscription.find(params[:id])
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

end
