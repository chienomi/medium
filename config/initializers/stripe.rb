Rails.configuration.stripe = {
  :publishable_key => ENV['S_PUBLISHABLE_KEY'],
  :secret_key      => ENV['S_SECRET_KEY']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]