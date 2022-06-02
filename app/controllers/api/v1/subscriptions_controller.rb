class Api::V1::SubscriptionsController < ApplicationController

  def create
    subscription = Subscription.new(subscription_params)
    if subscription.save
      render json: SubscriptionSerializer.show_new_subscription(subscription)
    else
      render json: SubscriptionSerializer.subscription_not_created  
    end
  end


    private

    def subscription_params
      params.require(:subscription).permit(:customer_id, :tea_id, :title, :price, :status, :frequency)
    end

end
