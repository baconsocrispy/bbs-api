class CookieRevokeController < Doorkeeper::TokensController
  private
  # override token implementation to get access token from request.cookies
  # instead of params['token']
  def token
    @token ||=
      if params[:token_type_hint] == "refresh_token"
        Doorkeeper.config.access_token_model.by_refresh_token(request.cookies['access_token'])
      else
        Doorkeeper.config.access_token_model.by_token(request.cookies['access_token']) ||
          Doorkeeper.config.access_token_model.by_refresh_token(request.cookies['access_token'])
      end
  end
end