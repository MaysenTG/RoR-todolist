ActiveAdmin.register_page "Dashboard" do
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span I18n.t("active_admin.dashboard_welcome.welcome")
        small I18n.t("active_admin.dashboard_welcome.call_to_action")
      end
    end

    # Here is an example of a simple dashboard with columns and panels.
    
    columns do
      column do
        panel "Info" do
          h2 "Welcome to ActiveAdmin.", :style => "text-align: center;"
        end
      end
    end

    columns do
      column do
        panel "Recent todos" do
          ul do
            Todo.all.map do |todo|
              h3 link_to(todo.title, admin_todos_path(todo))
            end
          end
        end
      end
    end
  end # content
end
