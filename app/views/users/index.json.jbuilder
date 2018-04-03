json.array!(@users) do |user|
  json.extract! user, :id, :user_name, :password, :email, :tel, :gill, :lv, :yen
  json.url user_url(user, format: :json)
end
