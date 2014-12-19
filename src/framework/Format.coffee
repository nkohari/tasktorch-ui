StackType = require 'framework/enums/StackType'

exports.stackName = ({stack, owner, team, currentUser}) ->

  formatPossessive = ->
    if owner?
      if owner.id == currentUser.id
        return 'My'
      else
        return "#{owner.name}'s"
    else
      return team.name

  switch stack.type
    when StackType.Queue
      return "#{formatPossessive()} Queue"
    when StackType.Inbox
      return "#{formatPossessive()} Inbox"
    when StackType.Drafts
      return "#{formatPossessive()} Drafts"
    else
      return stack.name
