class AdminController < ApplicationController
  def index
    @rules = Rule.all
    
  end
end
