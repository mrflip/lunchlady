class SpecialPagesController < ApplicationController
  before_filter :authenticate_user!, :except => [:homepage]

  def homepage
  end

  def grid
  end

  def text
    flash.now[:alert]   = "This is an alert"
    flash.now[:notice]  = "This is a notice"
    flash.now[:success] = "This is a success"
  end
end
