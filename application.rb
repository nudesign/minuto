require 'sinatra'
require 'erb'
require 'sass'

#Configuration at Startup
configure do
  #Set SCSS Options for CSS compilation
  set :scss, {:style => :compact, :debug_info => false}
end

helpers do
  # If @title is assigned, add it to the page's title.
  def title
    @title ? "#{@title} | festival do minuto" : "festival do minuto"
  end

  def partial(page, options={})
    erb page.to_sym, options.merge!(:layout => false)
  end
end

#Rendering the stylesheets
get '/stylesheets/:name.css' do
  content_type 'text/css', :charset => 'utf-8'
  scss (:"stylesheets/#{params[:name]}")
end

get '/' do
  erb :home
end

get '/:page' do
  erb params[:page].to_sym
end

get '/:dir/:name' do
  erb "/#{params[:dir]}/#{params[:name]}".to_sym
end
