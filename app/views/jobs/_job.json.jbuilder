json.extract! job, :id, :title, :desc, :created_at, :updated_at
json.url job_url(job, format: :json)
