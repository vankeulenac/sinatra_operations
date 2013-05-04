require 'sinatra/base'
require_relative './lib/panels'

class PanelApp < Sinatra::Base
  get "/" do
    @panels = Panel.all
    @panels.to_json
  end
end
