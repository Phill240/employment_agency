require "rails_helper"

describe Job do
  
  it "is valid with a first_name, last_name, salary, department and job" do
    expect(build(:employee)).to be_valid
  end
  
  it "is invalid without a first_name" do
    employee = build(:employee, first_name: nil)
    employee.valid?
    expect(employee.errors[:first_name]).to include("can't be blank")
  end
  
  it "is invalid without a last_name" do
    employee = build(:employee, last_name: nil)
    employee.valid?
    expect(employee.errors[:last_name]).to include("can't be blank")
  end
  
  it "is invalid without a salary" do
    employee = build(:employee, salary: nil)
    employee.valid?
    expect(employee.errors[:salary]).to include("can't be blank")
  end
  
  it "is invalid without a department" do
    employee = build(:employee, department_id: nil)
    employee.valid?
    expect(employee.errors[:department_id]).to include("can't be blank")
  end
  
  it "is invalid without a job" do
    employee = build(:employee, job_id: nil)
    employee.valid?
    expect(employee.errors[:job_id]).to include("can't be blank")
  end
  
  it "returns a full name as a string" do
    employee = build(:employee, first_name: "John", last_name: "Smith")
    expect(employee.full_name).to eq "John Smith"
  end
  
  it "creates an action object with job, department and salary after creating" do
    employee = create(:employee)
    expect(employee.hire_actions.length).to eq 1
    
    hire_action = employee.hire_actions.first
    expect(hire_action.job_id_new).to         eq employee.job_id
    expect(hire_action.department_id_new).to  eq employee.department_id
    expect(hire_action.salary_new).to         eq employee.salary
  end
  
  it "creates an action object after updating" do
    employee = create(:employee)
    old_department_id = employee.department_id
    old_job_id = employee.job_id
    old_salary = employee.salary
    
    new_department_id = create(:department).id
    new_job_id = create(:job).id
    new_salary = 120000
    
    employee.update( department_id: new_department_id, job_id: new_job_id, salary: new_salary )
    expect(employee.transfer_actions.length).to eq 1
    
    transfer_action = employee.transfer_actions.first
    
    expect(transfer_action.job_id_old).to         eq old_job_id
    expect(transfer_action.job_id_new).to         eq new_job_id
    expect(transfer_action.department_id_old).to  eq old_department_id
    expect(transfer_action.department_id_new).to  eq new_department_id
    expect(transfer_action.salary_old).to         eq old_salary
    expect(transfer_action.salary_new).to         eq new_salary    
  end
  
  it "creates an action object after dismissing" do
    employee = create(:employee)
    employee.update( is_fired: true )
    
    expect(employee.hire_actions.length).to eq 1    
  end
        
  
end