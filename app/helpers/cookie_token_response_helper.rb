module CookieTokenResponse
  # remove access token and access type from response body
  def body
    super.except('access_token', 'token_type')
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

    # ensure secure parameter is set in production
    if Rails.env.production?
      cookie_args.push('Secure')
    end

    # stringify the cookie args
    cookie = cookie_args.join(';')

    # add cookie to doorkeeper default response
    super.merge({ 'Set-Cookie' => cookie })
  end
end