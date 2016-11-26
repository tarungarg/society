json.extract! election, :id, :voting_start_date, :voting_end_date, :years_range, :win_user, :created_at, :updated_at
json.url election_url(election, format: :json)
