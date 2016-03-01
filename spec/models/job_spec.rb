require "rails_helper"

describe Job do
  
  it "is valid with a name" do
    expect(build(:job)).to be_valid
  end
  
  it "is invalid without a name" do
    job = build(:job, name: nil)
    job.valid?
    expect(job.errors[:name]).to include("can't be blank")
  end

end