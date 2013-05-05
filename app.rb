require 'sinatra/base'
require_relative './lib/panels'

class PanelApp < Sinatra::Base

  set connections: []

  get "/" do
    content_type :json
    @panels = Panel.to_json
  end
  
  get "/stream" do
    content_type "text/event-stream"
    stream :keep_open do |out|
      settings.connections << out
      out.callback { settings.connections.delete(out) }
    end
  end

  get "/fun" do
    settings.connections.each { |out| out << "data: HELLO\n\n" }
    204
  end
end
