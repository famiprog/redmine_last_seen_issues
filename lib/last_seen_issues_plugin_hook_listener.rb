class LastSeenIssuesPluginHookListener < Redmine::Hook::ViewListener
    render_on :view_issues_show_details_bottom, :partial => "last_seen_issues_plugin/update_last_seen_issues"
end