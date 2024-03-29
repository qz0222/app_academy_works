require 'addressable/uri'
require 'rest-client'

def index_users
    url = Addressable::URI.new(
      scheme: 'http',
      host: 'localhost',
      port: 3000,
      path: '/users.html'
    ).to_s

    puts RestClient.get(url)
end

index_users

def create_user(name, email=nil)
  url = Addressable::URI.new(
    scheme: 'http',
    host: 'localhost',
    port: 3000,
    path: '/users.json'
  ).to_s

  begin
    puts RestClient.post(
      url,
      { user: { name: name, email: email } }
    )
  rescue RestClient::Exception

  end
end

# create_user("Gizmo", "gizmo@gizmo.gizmo")
create_user("Gizmoa1")
