Hints = {}

Hints['email'] = """
If you enter an email address associated with a Gravatar account, it will be used
for your avatar on TaskTorch.
"""

Hints['username'] = """
This is the name that your team members will see. Be sure to make it something
that they can use to recognize you!
"""

Hints['stacks'] = """
If you aren't ready to work on a card yet, you can set it aside in a stack
and come back to it later.
"""

Hints['delete-stack'] = """
Deleting a stack is immediate and permanent. You cannot delete a stack that
has cards in it; they must first be moved to another stack.
"""

Hints['delete-team'] = """
Deleting a team is immediate and permanent. You should only delete a team if
you're sure that it is no longer necessary.
"""

Hints['create-kind-custom'] = """
Start from scratch to define your own custom card kind
"""

Hints['create-kind-template'] = """
Start with an example, which you can then customize to fit your needs:
"""

Hints['create-kind-workflow'] = """
What basic process do you follow for all work of this type? Actions will be created
within these stages, and they'll be used as columns on the Big Picture screen.
Your card kind must define at least one stage; if there isn't really a workflow
for this kind of work, just create a single stage called Checklist. You can drag
stages to reorder them.
"""

Hints['create-kind-default-actions'] = """
Are there some actions that you always perform when doing work of this kind?
When someone creates a card of this kind, these actions will be added by default.
You can drag and drop the actions to reorganize them, or move them between stages.
"""

Hints['create-kind-review'] = """
Take a moment to review your configuration below. If you're happy with your
settings, click Create Kind!
"""

Hints['accept-card'] = """
This will move it to your priorities list, which lets everyone know that
you intend to work on it. Normally, it will be placed at the end of your list, but
you can choose to make it your new top priority instead.
"""

Hints['complete-card'] = """
By marking this card as complete, you're telling everyone that no more work
needs to be done on the card. Complete cards are sent to the archive.
"""

Hints['delete-card'] = """
Deleting a card immediately and permanently removes it. If you've just finished
work on the card, you should mark it as complete instead of deleting it.
"""

Hints['pass-card'] = """
Passing a card to someone else means that you're asking them to take over 
responsibility for the work it describes. The card will be delivered to the 
user or team's inbox, where it can be accepted or passed on to someone else.
"""

Hints['restore-card'] = """
If you've accidentally marked this card as complete or moved it to the trash,
restoring it will re-deliver it to your inbox.
"""

Hints['create-goal'] = """
A goal is a long-term objective, involving several cards, that you want to
accomplish. It might be a project with a definitive end date, or an ongoing
initiative like "Improve Documentation". The status of goals is visible on
the Big Picture screen.
"""

Hints['send-invites'] = """
Enter the email addresses for the people you'd like to invite. They'll receive
a message from us with a link that they can use to join your organization.
If they don't already have a TaskTorch account, they'll be able to create one. 
"""

Hints['change-kind-workflow'] = """
Here, you can change the stages and default actions for cards of this kind.
You can drag both stages and default actions to reorganize them. Changes to
default actions will only affect new cards, but changes to the name or order
of stages will affect all cards of this kind. Be careful!
"""

Hints['delete-stage'] = """
If you choose to delete this stage, any actions currently in the stage will be
moved to the end of stage you select. Deleting a stage is permanent, and cannot be undone!
"""

Hints['org-memberships'] = """
This is the list of people who have access to your organization. Those marked as leaders
are allowed to manage memberships, including inviting others to join and deactivating
memberships.
"""

Hints['org-email'] = """
This email address will be used for billing information and receipts.
"""

Hints['archive-goal'] = """
If you archive this goal, no more cards can be added to it, and it will no longer be
shown on the Big Picture screen. Cards that have already been added to the goal will
not be removed.
"""

Hints['restore-goal'] = """
If you restore this goal, it will appear again on the Big Picture screen, and more
cards can be added to it.
"""

Hints['delete-goal'] = """
Deleting a goal is immediate and permanent. If you delete this goal, it will remove
all cards from it, and it will no longer appear on the Big Picture screen.
"""

Hints['archive-kind'] = """
If you archive this kind, it will no longer be shown on the Big Picture screen, and
no new cards of the kind can be created. Existing cards of this kind will not be
removed.
"""

Hints['restore-kind'] = """
If you restore this kind, it will appear again on the Big Picture screen, and more
cards of the kind can be created.
"""

module.exports = Hints
