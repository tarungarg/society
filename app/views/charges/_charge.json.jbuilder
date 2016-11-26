json.extract! charge, :id, :from_date, :to_date, :period, :amount, :created_at, :updated_at
json.url charge_url(charge, format: :json)
