class LastSeenIssuesPluginSettings

    public

    def self.get_setting(name)
        return Setting.plugin_redmine_last_seen_issues_plugin[name]
    end
end