# Plugin's routes
get 'last_seen_issues', :to => 'last_seen_issues_plugin#open_popup'
get 'show_last_seen_issues', :to => 'last_seen_issues_plugin#show_last_seen_issues'