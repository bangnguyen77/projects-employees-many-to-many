require("spec_helper")

describe(Project) do
  it("has many employees") do
    test_project = Project.create({:name => "Terribly important project"})
    test_employee1 = test_project.employees.new({:name => "Marie-Grace Gardner"})
    test_employee2 = test_project.employees.new({:name => "Bob"})
    expect(test_project.employees()).to(eq([test_employee1,test_employee2]))
  end
end
