// global: positioning last_seen_issues entry before logged in div
$(document).ready(function () {
    var $login_menu = $("div#loggedas");
    var $li = $(".last-seen-issues");
    $($li).prependTo($login_menu);
});

function updateLastSeenIssues(issueId, displayLimit) {
    var lastSeenIssuesKey = "last_seen_issues";
    var lastSeenIssuesQueue = [];
    if (localStorage.getItem(lastSeenIssuesKey)) {
        lastSeenIssuesQueue = JSON.parse(localStorage.getItem(lastSeenIssuesKey));
    }

    // if id already exists remove it, will be added at the top of queue because becomes latest issue seen
    if (lastSeenIssuesQueue.includes(issueId)) {
        var indexOfExistingId = lastSeenIssuesQueue.indexOf(issueId);
        lastSeenIssuesQueue.splice(indexOfExistingId, 1);
    }

    // add id as first element
    lastSeenIssuesQueue.unshift(issueId);

    // remove last extra elements if setting limit is exceded
    if (lastSeenIssuesQueue.length > displayLimit) {
        var nrOfDeletedElements = lastSeenIssuesQueue.length - displayLimit;
        lastSeenIssuesQueue.splice(lastSeenIssuesQueue.length - nrOfDeletedElements);
    }

    localStorage.setItem(lastSeenIssuesKey, JSON.stringify(lastSeenIssuesQueue));
}

function removeDeletedOrExtraIds(removeIds) {
    var lastSeenIssuesKey = "last_seen_issues";
    var lastSeenIssuesQueue = [];
    
    if (localStorage.getItem(lastSeenIssuesKey)) {
        lastSeenIssuesQueue = JSON.parse(localStorage.getItem(lastSeenIssuesKey));

        // remove ids for deleted/extra issues
        if (removeIds && removeIds.length > 0) {
            for (var id of removeIds) {
                var index = lastSeenIssuesQueue.indexOf(id);
                if (index !== -1) {
                    lastSeenIssuesQueue.splice(index, 1);
                }
            }
        }

        localStorage.setItem(lastSeenIssuesKey, JSON.stringify(lastSeenIssuesQueue));
    }
}