## Installation
`rails new bbs-api --api --database=postgresql`

## General Configuration
.DS_Store
added `.DS_Store` to .gitignore to prevent pushing to remote repository

### Server Setup
Set Puma port to 3001 in Puma config file

### DB Setup
`rails db:create`

### CORS
Since frontend and backend are separate apps running on different ports, use the rack-cors
gem to allow CORS. 
* add `rack-cors` gem to development/production group in gemfile
* `bundle install`
* in `config/initializers/cors.rb` uncomment everything and configure resource list appropriateley
* replace `example.com` with `http://localhost:3000` (in production put the primary domain(s))
* under resource "*" and under 'headers: any', add 'expose: ['Authorization']'

* helpful: https://medium.com/ruby-daily/understanding-cors-when-using-ruby-on-rails-as-an-api-f086dc6ffc41

## DEVISE AUTH
As this is an API-only backend, I am using Devise and Devise-jwt to manage
authentication and authorization. Rather than using cookie/session-based
auth, devise-jwt creates JSON-web-tokens that allow for stateless authentication
(the jwt is stored on the frontend on login and each backend request is 
authenticated using the token rather than storing a logged-in state in a 
session table). 

* add devise and devise-jwt gems to Gemfile
* `bundle install`
* install devise `rails g devise:install`
* add `require 'devise'` and `require devise/jwt` to top of config/application.rb
* In `config/initializers/devise.rb` set navigational formats to empty since this is API-Only:

` config.navigational_formats = []`

* configure routes (see routes.rb)
* configure jwt (see below/devise.rb)

```
# ==> Configuration for JWT
  config.skip_session_storage = [:http_auth]

  config.jwt do |jwt|
    # secret is used to 'sign'/authenticate tokens received from the client
    jwt.secret = Rails.application.credentials.fetch(:secret_key_base)
  
    # appends jwt token to Authorization header as Bearer + token on login POST
    jwt.dispatch_requests = [
      ['POST', %r{^/login$}]
    ]
  
    # removes jwt token from Authorization header on logout DELETE
    jwt.revocation_requests = [
      ['DELETE', %r{^/logout$}]
    ]
  
    # sets the token's expiration time
    jwt.expiration_time = 60.minutes.to_i
  end
```

Add `:jwt_authenticatable, :jwt_revocation_strategy: self` to User model:

```
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, :jwt_revocation_strategy: self
```

### Rack Disabled Session Error
When creating a new session, I was getting a sessions have been disabled error. In order to fix this, I created and included a module that creates a fake rack session. See `rack_session_fix.rb` in concerns.

### Doorkeeper Setup
Add doorkeeper gem for OAuth security??
help: https://www.youtube.com/watch?v=Kwm4Edvlqhw
help: https://curity.io/resources/learn/the-token-handler-pattern/

### JSON Serializer


### Routing/Namespace
https://chriskottom.com/articles/versioning-a-rails-api/


### Doorkeeper Setup
## Basic Installation
* `bundle add doorkeeper`
* `bundle install`
* install doorkeeper: `rails g doorkeeper:install`
* restart server if you get uninitialized constant error for Doorkeeper
* generate migration file: `rails g doorkeeper:migration`

## Migration Configuration
* remove `null: false` from the `redirect_uri` in the oauth_applications block (this is not necessary unless using 3rd party authentication apps like Google to login)
* comment out the `oauth_access_grants` block and its foreign_keys. This is only if you anticipate user's needing to grant access to 3rd party apps to have read/write access to their app
* since a Devise user model already exists, add relevant foreign key to oauth_access_token table:
`add_foreign_key :oauth_access_tokens, :users, column: :resource_owner_id`
* add corresponding associations to User model.
```
has_many :access_tokens,
          class_name: 'Doorkeeper::AccessToken',
          foreign_key: :resource_owner_id,
          dependent: :destroy
```
* run migration: `rails db:migrate`

## Initializer Configuration
* uncomment `api_only` to skip CSRF protections, and respond with json
* uncomment ` base_controller 'ActionController::Base'` and change to `ActionController::API`
the base controller will re-add CSRF protections
* update the authentication method: 
comment out `resource_owner_authenticator` block and add:
```
resource_owner_from_credentials do
  User.authenticate(params[:email], params[:password])
end
```
This tells doorkeeper to use the email and password provided at login to authenticate the user.




## Help
https://codingitwrong.com/2018/11/02/cookie-based-token-storage-with-doorkeeper.html
https://curity.io/resources/learn/the-token-handler-pattern/
