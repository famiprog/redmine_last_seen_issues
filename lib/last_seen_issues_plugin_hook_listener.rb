class LastSeenIssuesPluginHookListener < Redmine::Hook::ViewListener
    render_on :view_issues_show_details_bottom, :partial => "last_seen_issues_plugin/update_last_seen_issues"
    render_on :view_layouts_base_html_head, :partial => "last_seen_issues_plugin/html_head"
end