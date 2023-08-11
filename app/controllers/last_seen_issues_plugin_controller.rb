class LastSeenIssuesPluginController < ApplicationController

    include QueriesHelper

    def open_popup
        @columns = retrieve_query_from_session(IssueQuery).inline_columns.map{|query_column| { 'caption' => query_column.caption, 'name' => query_column.name}}.to_json
        return render :action => 'open_popup'
    end
end