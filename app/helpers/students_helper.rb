# -*- coding: utf-8 -*-

module StudentsHelper

  def progress
    if @student.rank.blank?
      "\#0"
    else
      "\##{@student.rank}"
    end
  end

end
