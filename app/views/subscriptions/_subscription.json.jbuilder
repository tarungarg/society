json.extract! subscription, :id, :charge_id, :user_id, :paid, :created_at, :updated_at
json.url subscription_url(subscription, format: :json)
