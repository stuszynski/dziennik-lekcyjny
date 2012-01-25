# -*- coding: utf-8 -*-

module StudentsHelper

  def bullets(array)
    today = today_absence
    array.to_a.map do |d|
      today == d ? "<span class='today'>●</span>" : "●"
    end.join(' ').html_safe
  end

  def progress
    if @student.rank.blank?
      "\#0"
    else
      "\##{@student.rank}"
    end
  end

end
