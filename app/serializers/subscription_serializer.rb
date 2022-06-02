class SubscriptionSerializer

  def self.show_new_subscription(subscription)
    {
      data: {
        id: nil,
        type: "subscription",
        attributes: {
          subscription_id: subscription.id,
          title: subscription.title,
          price: subscription.price,
          status: subscription.status,
          frequency: subscription.frequency,
          tea_id: subscription.tea.id,
          customer_id: subscription.customer.id,
        }
      }
    }.to_json
  end
end
