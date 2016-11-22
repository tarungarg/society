json.extract! carpool, :id, :title, :desc, :user_id, :date, :routes, :created_at, :updated_at
json.url carpool_url(carpool, format: :json)