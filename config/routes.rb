# Plugin's routes
get 'last_seen_issues', :to => 'last_seen_issues#open_popup'
get 'show_popup_content', :to => 'last_seen_issues#show_popup_content'
get 'show_last_seen_issues', :to => 'last_seen_issues#show_last_seen_issues'