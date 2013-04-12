require 'sinatra/base'
require 'erb'
require 'sass'

require_relative 'helpers/init'

class Minuto < Sinatra::Base
  #Configuration at Startup
  configure do
    #Set SCSS Options for CSS compilation
    set :scss, {:style => :compact, :debug_info => false}
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

  get '/:dir/:page' do
    erb "/#{params[:dir]}/#{params[:page]}".to_sym
  end

end
