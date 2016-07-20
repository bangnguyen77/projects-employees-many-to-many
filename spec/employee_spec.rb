require("spec_helper")

describe(Employee) do
  it("belongs to a project") do
    test_project = Project.create({:name => "Very important project"})
    test_employee1 = test_project.employees.new({:name => 'Bob'})
    expect(test_project.employees()).to(eq([test_employee1]))
  end
end
