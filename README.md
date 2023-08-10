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

### Routing/Namespace
https://chriskottom.com/articles/versioning-a-rails-api/


