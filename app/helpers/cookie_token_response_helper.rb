module CookieTokenResponseHelper
  # remove access token and access type from response body
  def body
    return if !token

    # add status message to response body
    status_response = {
      'status' => '200',
      'message' => 'Authorization successful'
    }

    # remove access token from response body
    super.except('access_token', 'token_type').merge(status_response)
  end

  # add cookie to response headers if token present
  def headers
    return if !token

    # set cookie parameters
    cookie_args = [
      "access_token=#{ token.token }",
      'Path=/',
      'HttpOnly'
    ]

    if Rails.env.development?
      cookie_args.push('SameSite=Lax')
    end

    # ensure secure parameter is set in production
    if Rails.env.production?
      cookie_args.push('Secure')
      cookie_args.push('SameSite=Lax')
    end

    # stringify the cookie args
    cookie = cookie_args.join(';')

    # add cookie to doorkeeper default response
    super.merge({ 'Set-Cookie' => cookie })
  end
end