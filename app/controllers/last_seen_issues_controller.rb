class LastSeenIssuesController < ApplicationController

    include QueriesHelper
    helper :all

    def open_popup
        return render :action => 'open_popup'
    end

    def show_last_seen_issues 
        @issues = []
        @remove_ids = []
        query = retrieve_query_from_session(IssueQuery)
        @columns = query.nil? ? retrieve_query(IssueQuery).inline_columns : query.inline_columns
        ids = params[:ids].split(",");
        issues_display_limit = LastSeenIssuesSettings.get_max_number_of_issues

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