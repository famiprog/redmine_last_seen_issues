Redmine::Plugin.register :redmine_last_seen_issues do
    name 'Redmine last seen issues plugin'
    author 'famiprog'
    description 'For detailed documentation see the link below.'
    version '1.0.1-SNAPSHOT'
    url 'https://github.com/famiprog/redmine-last-seen-issues'
    author_url 'https://github.com/famiprog'
  
    menu :account_menu, :last_seen_issues,
        { :controller => 'last_seen_issues', :action => 'open_popup' },
        :html => { :remote => true }, :caption => :label_last_seen_issues_menu_entry, :if => Proc.new {User.current.logged?}
    
    # default values for settings, and its render
    # Note: default values appear only when there are no settings saved in db.
    settings :default => {'empty' => true, 
                          :number_of_issues_displayed => '5' }, 
              :partial => 'settings/last_seen_issues_settings'
  
    require File.expand_path('lib/last_seen_issues_hook_listener', __dir__)
    require File.expand_path('lib/last_seen_issues_settings', __dir__)
end
