# -*- coding: utf-8 -*-

class ApplicationController < ActionController::Base

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

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

  helper_method :current_user

  private

  def current_user
    begin
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue Mongoid::Errors::DocumentNotFound
      nil
    end
  end

end
