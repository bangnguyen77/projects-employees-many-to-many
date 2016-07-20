require("bundler/setup")
Bundler.require(:default)
require('pry')

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get("/") do
  erb(:index)
end

get("/employees") do
  @employees = Employee.all()
  erb(:employees)
end

get("/projects") do
  @projects = Project.all()
  erb(:projects)
end

post("/employees") do
  name = params.fetch("employee_name")
  Employee.create({:name => name})
  redirect("/employees")
end

post("/projects") do
  name = params.fetch("project_name")
  Project.create({:name => name})
  redirect("/projects")
end

get("/employees/:id") do
  @employee = Employee.find(params.fetch("id").to_i())
  if @employee.projects()
    @employee_projects = @employee.projects()
  else
    @employee_projects = nil
  end
  @projects = Project.all
  erb(:employee)
end

get("/projects/:id") do
  @project = Project.find(params.fetch("id").to_i())
  @employees = Employee.all
  erb(:project)
end

patch("/employees/:id") do
  if params.fetch("form_id").==("update_project_id")
    new_project_id = params.fetch("project_id").to_i()
    @employee = Employee.find(params.fetch("id").to_i())
    project_ids_array = []
    @employee.projects().each() do |project|
      project_ids_array.push(project.id())
    end
    project_ids_array.push(new_project_id)
    @employee.update({:project_ids => project_ids_array})
    redirect back
  else
    remove_project_id = params.fetch("project_id").to_i()
    remove_project = Project.find(remove_project_id)
    @employee = Employee.find(params.fetch("id").to_i())
    @employee.projects.destroy(remove_project)
    redirect back
  end
end

delete("/employees/:id") do
  @employee = Employee.find(params.fetch("id").to_i())
  if @employee.destroy()
    redirect("/employees")
  else
    erb(:employee)
  end
end

patch("/employees/:id") do
  if params.fetch("form_id").==("update_project_id")

  else
    remove_project_id = params.fetch("project_id").to_i()
    remove_project = Project.find(remove_project_id)
    @employee = Employee.find(params.fetch("id").to_i())
    @employee.projects.destroy(remove_project)
    redirect back
  end
end

patch("/projects/:id") do
  if params.fetch("form_id").==("add_employee_id")
    employee = Employee.find(params.fetch("employee_id").to_i())
    @project = Project.find(params.fetch("id").to_i())
    @project.employees.push(employee)
  else
    remove_employee_id = params.fetch("employee_id").to_i()
    remove_employee = Employee.find(remove_employee_id)
    @project = Project.find(params.fetch("id").to_i())
    @project.employees.destroy(remove_employee)
  end
  redirect back
end

delete("/projects/:id") do
  @project = Project.find(params.fetch("id").to_i())
  if @project.destroy()
    redirect("/projects")
  else
    erb(:project)
  end
end
