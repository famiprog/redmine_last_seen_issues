Redmine::Plugin.register :redmine_last_seen_issues_plugin do
    name 'Redmine last seen issues plugin'
    author 'famiprog'
    description 'For detailed documentation see the link below.'
    version '0.0.1'
    url 'https://github.com/famiprog/redmine-last-seen-issues'
    author_url 'https://github.com/famiprog'
  
    menu :account_menu, :last_seen_issues_plugin, { :controller => 'last_seen_issues_plugin', :action => 'open_popup' }, :html => { :remote => true }, :first => true, :caption => :label_last_seen_issues_menu_entry

    # default values for settings, and its render
    # Note: default values appear only when there are no settings saved in db.
    settings :default => {'empty' => true, 
                          :number_for_last_displayed_issues_setting => '5' }, 
              :partial => 'settings/last_seen_issues_plugin_settings'
  
    # hook that will generate the (Re)start assist plugin action
    require File.expand_path('lib/last_seen_issues_plugin_hook_listener', __dir__)
    require File.expand_path('lib/last_seen_issues_plugin_settings', __dir__)
end
  