# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "http://localhost:3000",
            "http://brothers-sonsamerica.com",
            "https://brothers-sonsamerica.com",
            "http://www.brothers-sonsamerica.com",
            "https://www.brothers-sonsamerica.com",
            "http://api.brothers-sonsamerica.com",
            "https://api.brothers-sonsamerica.com",
            "https://bbs-app-drab.vercel.app"

    resource "*",
      headers: :any,
      expose: [ 'Authorization' ],
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: true
  end
end
