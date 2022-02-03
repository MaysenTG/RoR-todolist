ActiveAdmin.register Todo do
  
  batch_action :completed do |ids|
    batch_action_collection.find(ids).each do |todo|
      todo.completed = true
    end
    redirect_to collection_path, alert: "The posts have been completed."
  end
  
  
  batch_action :notcompleted do |ids|
    batch_action_collection.find(ids).each do |todo|
      todo.completed = false
    end
    redirect_to collection_path, alert: "The posts have been unchecked."
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
