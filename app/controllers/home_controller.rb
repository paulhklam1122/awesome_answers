class HomeController < ApplicationController
  # methods defined in controllers are called 'actions'
  def about
    # render text: "About Us!"

    # This tells Rails to look for a file: /app/views/home/about/html.erb
    # it will render the file and send it as a response.
    # layout: :application tells Rails to use: /app/view/layouts/application.html.erb
    # render :about, layout: "application"
    #the line above is redundant because it's the default Rails convention
  end
  def index
  end
  def greet
    @name = params[:name]
  end
end
