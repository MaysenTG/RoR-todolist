ActiveAdmin.register Todo do
  
  batch_action :toggle_completed do |ids|
    Todo.find(ids).each do |todo|
      todo.update(completed: not(todo.completed))
    end
    redirect_to collection_path, alert: "The posts have been updated."
  end
  
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :title, :description, :completed, :user_id
  #
  # or
  #
  permit_params do
    permitted = [:title, :description, :completed, :user_id]
    permitted
  end
  
end
