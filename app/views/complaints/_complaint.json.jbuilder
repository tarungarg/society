json.extract! complaint, :id, :title, :desc, :status, :created_at, :updated_at
json.url complaint_url(complaint, format: :json)