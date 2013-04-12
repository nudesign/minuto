# If @title is assigned, add it to the page's title.
def title
@title ? "#{@title} | festival do minuto" : "festival do minuto"
end

def partial(page, options={})
erb page.to_sym, options.merge!(:layout => false)
end
