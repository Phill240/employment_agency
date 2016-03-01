require "rails_helper"

describe Department do
  
  it "is valid with a name" do
    expect(build(:department)).to be_valid
  end
  
  it "is invalid without a name" do
    department = build(:department, name: nil)
    department.valid?
    expect(department.errors[:name]).to include("can't be blank")
  end

end