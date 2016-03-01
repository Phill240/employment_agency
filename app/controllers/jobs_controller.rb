class JobsController < ApplicationController
  
  # Shows a list of jobs
  def index
    @jobs = Job.all
  end
  
  # Shows a form for a new job
  def new
    @job = Job.new
  end
    
  # Creates a job
  def create
    @job = Job.new(job_params)
    
    if @job.save
      redirect_to jobs_path      
    else
      render 'new'      
    end    
  end
  
  private
  
  def job_params
    params.require(:job).permit(:name)
  end
  
end