class NamePickerController < ApplicationController
  def index
  end
  def pick
    @names = params[:names]
    @result = params[:names].split(",").shuffle.pop.downcase.capitalize
    render :index
  end
end
