class DepartmentsController < ApplicationController
  
  # Shows a list of departments
  def index
    @departments = Department.all
  end
  
  # Shows a form for a new department
  def new
    @department = Department.new
  end
    
  # Creates a department
  def create
    @department = Department.new(department_params)
    
    if @department.save
      redirect_to departments_path      
    else
      render 'new'      
    end    
  end
  
  private
  
  def department_params
    params.require(:department).permit(:name)
  end
  
end