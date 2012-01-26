# -*- coding: utf-8 -*-

class ApplicationController < ActionController::Base

  protect_from_forgery

  helper_method :today_absence, :bullets

  def today_absence
    time = Time.new
    "#{time.month}-#{time.day}"
  end

  def bullets(array)
    today = today_absence
    array.to_a.map do |d|
      today == d ? "<span class='today'>●</span>" : "●"
    end.join(' ').html_safe
  end

end
