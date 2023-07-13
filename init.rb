Redmine::Plugin.register :redmine_last_seen_issues_plugin do
    name 'Redmine last seen issues plugin'
    author 'famiprog'
    description 'For detailed documentation see the link below.'
    version '0.0.1'
    url 'https://github.com/famiprog/redmine-last-seen-issues'
    author_url 'https://github.com/famiprog'
  
    # default values for settings, and its render
    # Note: default values appear only when there are no settings saved in db.
    settings :default => {'empty' => true, 
                          :number_for_last_displayed_issues_settings => '5' }, 
              :partial => 'settings/last_seen_issues_plugin_settings'
  
    # hook that will generate the (Re)start assist plugin action
    # require File.expand_path('lib/last_seen_issues_plugin_plugin_hook_listener', __dir__)
    require File.expand_path('lib/last_seen_issues_plugin_settings', __dir__)
  
#     # need the helper to be available in _add_start_action.html.erb which
#     # is rendered by IssuesController (because of hook we defined in cripico_plugin_hook_listener)
#     if Rails.version > '6.0' # Redmine 5.0
#       Rails.application.config.after_initialize do
#         IssuesController.send(:helper, :crispico_plugin)
#         # Global helpers
#         ActionView::Base.include CrispicoPluginHelper
#         # this is to expose helper methods to the hook class as they are used inside the controller hooks
#         Redmine::Hook::Helper.include CrispicoPluginHelper
#         ActionView::Base.include CrispicoPluginMenuHelper
#       end
#     else
#       Rails.configuration.to_prepare do
#         IssuesController.send(:helper, :crispico_plugin)
#       end
#     end
#     IssuesController.send(:include, IssuesControllerPatch)
#     MessagesController.send(:include, MessagesControllerPatch)
#     Query.send(:include, CrispicoPluginQueryPatch)
#     Journal.send(:include, Patches::JournalPatch)
#     Message.send(:include, Patches::MessagePatch)
#     CrispicoPluginController.send(:helper, :crispico_plugin)
#   end
  
#   Redmine::WikiFormatting::Macros.register do
#     desc "Insert a badge for the diffable versions functionality of plcapp (see https://redmine.xops-online.com/issues/28566). Examples \n\n <pre>{{diffable_versions_badge(some-wiki-page)}}</pre>"
#     macro :diffable_versions_badge do |obj, args|
#       params = {
#         :username => User.current.login
#       }
  
#       # add page parameter only if argument exists
#       if args[0] and !args[0].empty?
#         params[:page] = args[0]
#       end
  
#       # to_query returns a string representation suitable for use as URL query string
#       link_to(image_tag("#{CrispicoPluginSettings.get_setting(:diffable_versions_image_url)}?#{params.to_query}", referrerpolicy: "no-referrer-when-downgrade"), "#{CrispicoPluginSettings.get_setting(:diffable_versions_ui_url)}?#{params.to_query}", referrerpolicy: "no-referrer-when-downgrade")
#     end
end
  