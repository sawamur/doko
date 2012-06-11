
require 'sinatra'
require 'doko'

get '/' do
  @url = "http://r.tabelog.com/tokyo/A1314/A131402/13007204/"
  erb :index
end

post '/' do
  @url = params[:url]
  @addrs = Doko.deep(@url)
  erb :index
end
