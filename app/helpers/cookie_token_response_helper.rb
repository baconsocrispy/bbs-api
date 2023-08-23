module CookieTokenResponse
  # override doorkeeper body method to remove access token 
  # and access type from response
  def body
    super.except('access_token', 'token_type')
  end

  # configure headers for doorkeeper response
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