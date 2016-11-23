json.extract! elections_participated_user, :id, :user_id, :electon_id, :created_at, :updated_at
json.url elections_participated_user_url(elections_participated_user, format: :json)