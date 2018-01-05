use Rack::Auth::Basic, "Restricted Area" do |username, password|
        [username, password] == ['admin','1234']
end
require 'rack/jekyll'
run Rack::Jekyll.new