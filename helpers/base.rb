# If @title is assigned, add it to the page's title.
def title
  @title ? "#{@title} | festival do minuto" : "festival do minuto"
end

def partial(page, options={})
  erb page.to_sym, options.merge!(:layout => false)
end

def development?; ENV['RACK_ENV'].to_sym == :development end
def production?;  ENV['RACK_ENV'].to_sym == :production  end
def test?;        ENV['RACK_ENV'].to_sym == :test        end
