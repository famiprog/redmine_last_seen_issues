class LastSeenIssuesController < ApplicationController

    include QueriesHelper
    # all helpers must be added, column_content can be patched by another plugin and other new methods calls will be undefined
    helper :all

    def open_popup
        return render :action => 'open_popup'
    end

    def show_popup_content
        @query = retrieve_custom_query params[:custom_query_id]
        @default_query_id = LastSeenIssuesSettings.get_setting(:default_custom_query)
        return render :partial => 'show_popup_content'
    end

    def show_last_seen_issues
        @issues = []
        @remove_ids = []
        @query = retrieve_custom_query params[:custom_query_id]
        # if issue ids are missing stop
        ids = params[:issues_ids].nil? || params[:issues_ids].empty? ? [] : params[:issues_ids].split(",")
        return render :partial => 'show_last_seen_issues' if ids.empty?

        issues_display_limit = LastSeenIssuesSettings.get_max_number_of_issues
        for id in ids do
            # check if id is a number, to_i return number until first non digit character, e.g '15test'.to_i => 15, 15.to_s != '15test' so will be rejected
            next if id != id.to_i.to_s
            # limit was reached, next id-s are extra and needs to be removed from local storage
            if @issues.length == issues_display_limit.to_i
                    @remove_ids << id.to_i 
            else
                issue = Issue.find_by(id: id.to_i)
                # issue was deleted or is not longer visible for the user, id must be removed from local storage
                issue.nil? || !issue.visible? ? @remove_ids << id.to_i : @issues << issue
            end
        end

        return render :partial => 'show_last_seen_issues'
    end

    private
    def retrieve_custom_query(custom_query_id)
        # retrieve query with query_id if exists in params (localStorage) otherwise by default one
        default_custom_query_id = LastSeenIssuesSettings.get_setting(:default_custom_query)
        find_custom_query_id = custom_query_id.nil? || custom_query_id.empty? ? default_custom_query_id : custom_query_id
        custom_query = find_custom_query_id.nil? || find_custom_query_id.empty? ? IssueQuery.default() : IssueQuery.find_by(id: find_custom_query_id.to_i)
        # check if the query still exists in DB
        custom_query = custom_query.nil? ? retrieve_query(IssueQuery) : custom_query
        return custom_query
    end
end