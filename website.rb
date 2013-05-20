require 'rubygems'
require 'sinatra'
require 'haml'


get '/' do
  @title = "Welcome, you can return your book here"
     haml :home
end

get '/late' do 
	@title = "Your book is too late, this will be fine"
	haml :late
end

get '/ontime' do 
	@title = "Thank you for handing in your book on time"
	haml :ontime
end
 

__END__
@@layout 
%html
 %body
 	- yield

@@home
%h1 Welcome, please return your book

@@late 
%h1 You are too late, this will be a fine

@@ontime
%h1 You are on time 
