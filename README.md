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
* add `credentials: true` to allow cookies in request

* helpful: https://medium.com/ruby-daily/understanding-cors-when-using-ruby-on-rails-as-an-api-f086dc6ffc41

## DEVISE AUTH
* add devise to Gemfile
* `bundle add devise`
* `bundle install`
* install devise `rails g devise:install`
* if using custom auth group, add `require 'devise'` to top of config/application.rb
* In `config/initializers/devise.rb` set navigational formats to empty since this is API-Only:

` config.navigational_formats = []`

* configure routes (see routes.rb)

### Rack Disabled Session Error
When creating a new session, I was getting a sessions have been disabled error. In order to fix this, I created and included a module that creates a fake rack session. See `rack_session_fix.rb` in concerns.

### Doorkeeper Setup
help: https://www.youtube.com/watch?v=Kwm4Edvlqhw
help: https://curity.io/resources/learn/the-token-handler-pattern/

### JSON Serializer


### Routing/Namespace
https://chriskottom.com/articles/versioning-a-rails-api/


### Doorkeeper Setup
Explain how this follows and doesn't follow OAuth2 protocols using Doorkeeper/Devise.
## Basic Installation
* `bundle add doorkeeper`
* `bundle install`
* install doorkeeper: `rails g doorkeeper:install`
* restart server if you get uninitialized constant error for Doorkeeper
* generate migration file: `rails g doorkeeper:migration`

## Migration Configuration
* remove `null: false` from the `redirect_uri` in the oauth_applications block (this is not necessary unless using 3rd party authentication apps like Google to login that send you to another page)
* comment out the `oauth_access_grants` block and its foreign_keys. This is only if you anticipate user's needing to grant access to 3rd party apps to have read/write access to their app. That's beyond the scope of this application.
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
This tells doorkeeper to use the email and password provided at login and to authenticate the user with the devise authenticate method.

* Add devise authentication method to User model.

```
# the authenticate method from devise documentation
def self.authenticate(email, password)
  user = User.find_for_authentication(email: email)
  user&.valid_password?(password) ? user : nil
end
```

* find grant_flows section and add:
`grant_flows %w[password]`

This tells doorkeeper that the password grant type is allowed

* uncomment `allow_blank_redirect_uri false` and set to `true`
This corresponds with removing the redirect_uri null false constraint in the migration

* Further development: implement refresh token, scopes

* I restricted the way client credentials (client_id, client_secret) are received to just basic auth
`client_credentials :from_basic`

## Create Client Application
In Rails console, create an application to generate client_id and client_secret. I called the frontend client application Next.js. Set the Client id, secret, name and grant_type as environment variables.

## Cookie Management
* Create a helper to update the default doorkeeper response to send the access_token as an HttpOnly cookie. (see `app/helpers/cookie_token_response_helper.rb` for implementation)

* The helper needs to be required and included in the `doorkeeper.rb` initializer

```
require './app/helpers/cookie_token_response_helper'
include CookieTokenResponse
```

* And it needs to be prepended to the default Doorkeeper token response outside of the `doorkeeper.config` block.

`Doorkeeper::OAuth::TokenResponse.send :prepend, CookieTokenResponse`

* To get doorkeeper to read the access_token from the cookie, find the access_token_methods section of the doorkeeper initializer and add this underneath:

` access_token_methods lambda { |request| request.cookies['access_token']}`

* On the frontend I needed to set `credentials: 'include'` for the cookie to store properly in the browser in development since the browser (Chrome) treats the different ports as cross-origin. 

* helpful tutorial: https://codingitwrong.com/2018/11/02/cookie-based-token-storage-with-doorkeeper.html

## Help

https://curity.io/resources/learn/the-token-handler-pattern/
https://medium.com/@ArturoAlvarezV/use-session-cookies-to-authenticate-a-user-with-a-rails-api-backend-hosted-in-heroku-on-one-domain-f702ddf8c07