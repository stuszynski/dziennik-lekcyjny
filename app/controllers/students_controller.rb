# -*- coding: utf-8 -*-

class StudentsController < ApplicationController

  include ActiveModel::MassAssignmentSecurity

  # zob. poniżej kod metod account_params i update

  attr_accessible :repositories, :nickname, :uid, :comments, :group, :id_number

  attr_accessible :repositories, :nickname, :uid, :comments, :group, :id_number,
    :rank, :full_name, :absences_list, :class_name, :year, :semester,
    :as => :admin

  load_and_authorize_resource
  # skip_authorize_resource :only => :index

  # GET /students
  # GET /students.json
  def index
    # logger.info "☻ request query parameters: #{request.query_parameters}"

    # logger.info "--> #{request.fullpath}"
    # logger.info "--> GITHUB_KEY: #{ENV['GITHUB_KEY']}"
    # logger.info "--> GITHUB_SECRET: #{ENV['GITHUB_SECRET']}"

    class_name = params[:class_name] || "unknown"
    year = params[:year] || "2011"
    semester = params[:semester] || "summer"

    if params[:class_name]
      @students = Student.where(class_name: class_name, year: year, semester: semester)
    else
      @students = Student.where(year: 2011, semester: "summer", class_name: "unallocated")
    end

    # @students = Student.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @students }
    end
  end

  # GET /students/admin
  def admin
    @students = Student.all
  end

  # GET /students/1
  # GET /students/1.json
  def show
    @student = Student.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @student }
    end
  end

  # GET /students/new
  # GET /students/new.json
  def new
    @student = Student.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @student }
    end
  end

  # GET /students/1/edit
  def edit
    @student = Student.find(params[:id])
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(params[:student])

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: 'Student was successfully created.' }
        format.json { render json: @student, status: :created, location: @student }
      else
        format.html { render action: "new" }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /students/1
  # PUT /students/1.json
  def update
    @student = Student.find(params[:id])

    # if @student.update_attributes(params[:student])
    if @student.update_attributes(account_params)
      redirect_to student_url(@student), notice: 'Student was successfully updated'
    else
      render action: "edit"
    end
  end

  # # PUT /students/1/not_present
  # def not_present
  #   @student = Student.find(params[:id])
  #   @student.add_to_set(:absences, today_absence)
  #   redirect_to students_url
  # end

  # PUT /students/1/not_present
  # PUT /students/1/not_present.json
  def not_present
    @student = Student.find(params[:id])

    respond_to do |format|
      if @student.add_to_set(:absences, today_absence)
        format.html { redirect_to students_url, notice: 'Student absences were successfully updated.' }
        format.json { render :json => { value: bullets(@student.absences) }.to_json }
      else
        format.html { render action: "edit" }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student = Student.find(params[:id])
    @student.destroy

    respond_to do |format|
      format.html { redirect_to admin_students_url, notice: 'Student was successfully destroyed' }
      format.json { head :no_content }
    end
  end

  protected

  def account_params
    role = current_user.admin? ? :admin : :default
    sanitize_for_mass_assignment(params[:student], role)
  end

end
