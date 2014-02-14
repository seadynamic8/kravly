ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    # div :class => "blank_slate_container", :id => "dashboard_default_message" do
    #   span :class => "blank_slate" do
    #     span I18n.t("active_admin.dashboard_welcome.welcome")
    #     small I18n.t("active_admin.dashboard_welcome.call_to_action")
    #   end
    # end

    columns do
      column do
        panel "Recent Ideas" do
          table_for Idea.recent.limit(5) do
            column :title do |idea|
              link_to idea.title, admin_idea_path(idea.id)
            end
            column :updated_at
          end
          strong { link_to "View All Ideas", admin_ideas_path }
        end
      end
      column do
        panel "New Users" do
          table_for User.newly_created.limit(5) do
            column :username do |user|
              link_to user.username, admin_user_path(user)
            end
            column :created_at
          end
          strong { link_to "View All Users", admin_users_path }
        end
      end
    end

    panel "Recent Comments" do
      table_for Comment.recent.limit(10) do
        column :body do |comment|
          link_to truncate( comment.body, length: 30 ), admin_comment_path(comment)
        end
        column :updated_at
      end
      strong { link_to "View All Comments", admin_comments_path }
    end


    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content


end
