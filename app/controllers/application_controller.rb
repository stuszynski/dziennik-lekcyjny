class ApplicationController < ActionController::Base

  protect_from_forgery

  helper_method :today_absence

  def today_absence
    time = Time.new
    "#{time.month}-#{time.day}"
  end

end
