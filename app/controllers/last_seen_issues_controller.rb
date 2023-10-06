class LastSeenIssuesController < ApplicationController

    include QueriesHelper
    # all helpers must be added, column_content can be patched by another plugin and other new methods calls will be undefined
    helper :all

    def open_popup
        return render :action => 'open_popup'
    end

    def show_popup_content
        # retrieve query with query_id if exists in params (localStorage) otherwise by default one
        @query = params[:custom_query_id].nil? || params[:custom_query_id].empty? ? retrieve_query(IssueQuery) : IssueQuery.find_by(id: params[:custom_query_id].to_i)
        # check if the query still exists in DB
        @query = @query.nil? ? retrieve_query(IssueQuery) : @query

        return render :partial => 'show_popup_content'
    end

    def show_last_seen_issues
        @issues = []
        @remove_ids = []
        # retrieve query with query_id if exists in params (localStorage) otherwise by default one
        @query = params[:custom_query_id].nil? || params[:custom_query_id].empty? ? retrieve_query(IssueQuery) : IssueQuery.find_by(id: params[:custom_query_id].to_i)
        # check if the query still exists in DB
        @query = @query.nil? ? retrieve_query(IssueQuery) : @query

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
                # issue was deleted, id must be removed from local storage
                issue.nil? ? @remove_ids << id.to_i : @issues << issue
            end
        end

        return render :partial => 'show_last_seen_issues'
    end
end