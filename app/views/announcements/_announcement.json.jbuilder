json.extract! announcement, :id, :title, :desc, :created_at, :updated_at
json.url announcement_url(announcement, format: :json)
