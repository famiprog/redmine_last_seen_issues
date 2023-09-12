class LastSeenIssuesPluginController < ApplicationController

    include QueriesHelper
    helper :all

    def open_popup
        return render :action => 'open_popup'
    end

    def show_last_seen_issues 
        @issues = []
        @remove_ids = []
        @columns = retrieve_query_from_session(IssueQuery).inline_columns
        ids = params[:ids].split(",");
        issues_display_limit = LastSeenIssuesPluginSettings.get_setting(:number_for_last_displayed_issues_setting)
        # for blank setting or not a number, default 5
        if (issues_display_limit.blank? || !(/\A\d+\z/).match(issues_display_limit))
          issues_display_limit = 5
        end

        for id in ids do
            # limit was reached, next id-s are extra and needs to be removed from local storage
            if @issues.length == issues_display_limit.to_i
                 @remove_ids << id.to_i 
            else
                issue = Issue.find_by(id: id.to_i)
                # issue was deleted, id must be removed from local storage
                issue.nil? ? @remove_ids << id.to_i : @issues << issue
            end
        end
        
        return render :partial => 'show_last_seen_issues'
    end
end