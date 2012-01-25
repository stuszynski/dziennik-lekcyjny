# -*- coding: utf-8 -*-

class Student

  include Mongoid::Document
  include Mongoid::MultiParameterAttributes

  field :last_name, type: String
  field :first_name, type: String
  field :id_number, type: Integer
  field :nickname, type: String
  field :absences, type: Array
  field :comments, type: String
  field :class_name, type: String
  field :group, type: String
  field :repositories, type: String
  field :rank, type: Integer
  field :year, type: Integer
  field :semester, type: Integer

  # getter and setter

  def full_name
    [first_name, last_name].join(' ')
  end

  def full_name=(name)
    split = name.split(/\s+/, 2)
    self.first_name = split.first
    self.last_name = split.last
  end

  # obróbka tablicy w formularzu

  def absences_list
    absences.to_a.join(' ') # .to_a handles nil attribute
  end

  def absences_list=(string)
    list = string.gsub(/[,\s]+/, ' ').split(' ') # najpierw normalizacja, póżniej split
    set(:absences, list)
  end

  default_scope asc(:group, :last_name, :first_name)

  set_callback(:save, :before) do |document|
    if document.class_name.empty?
      document.class_name = "unknown"
    end
    if document.group.empty?
      document.group = "unknown"
    end
  end

end
