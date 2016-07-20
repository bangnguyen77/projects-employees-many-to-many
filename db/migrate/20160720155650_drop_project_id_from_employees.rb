class DropProjectIdFromEmployees < ActiveRecord::Migration
  def change
    remove_column(:employees, :project_id, :integer)
  end
end
