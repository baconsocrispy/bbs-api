# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "http://localhost:3000",
            "https://superlative-fairy-8da059.netlify.app",
            "http://carterbacon.com",
            "https://carterbacon.com",
            "http://www.carterbacon.com",
            "https://www.carterbacon.com",
            "http://api.carterbacon.com",
            "https://api.carterbacon.com",
            "https://bbs-app-drab.vercel.app"

    resource "*",
      headers: :any,
      expose: [ 'Authorization' ],
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: true
  end
end
