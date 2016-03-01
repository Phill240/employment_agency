class EmployeesController < ApplicationController
  before_filter :load_employee, :except => [:index, :new, :create]
  
  # Shows a list of employees
  def index
    @employees = Employee.includes(:job, :department).all.order(id: :desc)
  end
  
  # Shows a form for a new employee
  def new
    @employee = Employee.new
  end
  
  # Shows all actions connected with user
  def show
    @actions = @employee.actions.includes(:department_old, :department_new, :job_old, :job_new).all.order(date: :desc)
  end
  
  # Creates an employee
  def create
    @employee = Employee.new(employee_new_params)
    
    if @employee.save
      redirect_to employees_path      
    else
      render 'new'      
    end    
  end
  
  # Shows a form for an existent employee (only first and last names can be changed)
  def edit  
  end
    
  # Updates first and last names of an employee
  def update    
    if @employee.update(employee_edit_params)
      redirect_to employees_path     
    else
      render 'edit'        
    end    
  end
  
  # Shows a form which allows to transfer an employee to another department
  def transfer 
  end
  
  # Updates a job, a department and a salary 
  def move  
    if @employee.update(employee_move_params)
      redirect_to employees_path     
    else
      render 'transfer'        
    end      
  end
  
  # Shows a form which allows to hire an employee
  def dismiss 
  end
  
  # Fires an employee
  def fire
    if @employee.update(employee_fire_params)
      redirect_to employees_path     
    else
      render 'dismiss'        
    end        
  end
    
  
  private
  
  def load_employee
    @employee = Employee.find(params[:id])      
  end
  
  def employee_edit_params
    employee_params :first_name, :last_name
  end
  
  def employee_move_params
    employee_params :department_id, :job_id, :salary, :action_date
  end
  
  def employee_new_params
    employee_edit_params.merge employee_move_params
  end
  
  def employee_fire_params
    employee_params :is_fired, :dismissal_reason, :action_date
  end
    
  def employee_params(*param_list)    
    params.require(:employee).permit(param_list)
  end
  
end