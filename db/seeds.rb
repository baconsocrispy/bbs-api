# seed doorkeeper applications
if Doorkeeper::Application.count.zero?
  Doorkeeper::Application.create(name: "Next.js", redirect_uri: "", scopes: "")
end
