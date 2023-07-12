# redmine-last-seen-issues

This is a plugin for [Redmine](https://www.redmine.org/).

## The need

When organzing and collaborating within our team, we often "touch" (i.e. see, edit, discuss, etc.) many tasks in a relatively short time span. We often had the need to reopen "that task from 5 minutes ago". Sometimes reopening a closed tab would help. Maybe sometimes the browser history. And other times we just texted a co-worker: "what was again the task # we just discussed?". We cannot hide, that this process generates often a bit of frustration.

## The solution

Have a popup, that can be accessed quickly, that renders quickly and that shows the last N issues that we have opened. We saw this pattern in other apps as well.

TBD screenshot

## Implementation details

We need to store, per user, the last N tasks that were opened. We choose not to store this info in the DB. And store it in the browser's local storage.
* The implementation of this plugin is very light.
* We don't add any performance penalty to the "open page" scenario.
* We can render the popup very fast.
* Of course, there is a tradeoff. The list of last seen issues is not in sync across devices. But we estimate that this limitation is relatively small in comparison with the above advantages.

When the popup renders, for each "last seen issue", it loads from local storage: the issue # and subject. Meanwhile a server request is made in order to bring the rest of the data (and potentially to update the name of the issue).
