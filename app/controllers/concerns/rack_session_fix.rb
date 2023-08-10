# handles disable session error: 
# ActionDispatch::Request::Session::DisabledSessionError 
# (Your application has sessions disabled. To write to the session you 
# must first configure a session store)

module RackSessionFix
  extend ActiveSupport::Concern

  class FakeRackSession < Hash
    def enabled?
      false
    end
  end

  included do
    before_action :set_fake_rack_session_for_devise
    private
    def set_fake_rack_session_for_devise
      request.env['rack.session'] ||= FakeRackSession.new
    end
  end
end