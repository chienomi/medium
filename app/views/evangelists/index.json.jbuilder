json.array!(@evangelists) do |evangelist|
  json.extract! evangelist, :id, :title, :post_short, :post, :user_id, :demo_id
  json.url evangelist_url(evangelist, format: :json)
end
