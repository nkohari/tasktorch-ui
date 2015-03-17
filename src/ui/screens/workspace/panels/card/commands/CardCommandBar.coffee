React             = require 'react'
PropTypes         = require 'ui/framework/PropTypes'
CardStatus        = require 'data/enums/CardStatus'
StackType         = require 'data/enums/StackType'
ArchiveCommandBar = React.createFactory(require 'ui/screens/workspace/panels/card/commands/bars/ArchiveCommandBar')
BacklogCommandBar = React.createFactory(require 'ui/screens/workspace/panels/card/commands/bars/BacklogCommandBar')
DraftsCommandBar  = React.createFactory(require 'ui/screens/workspace/panels/card/commands/bars/DraftsCommandBar')
InboxCommandBar   = React.createFactory(require 'ui/screens/workspace/panels/card/commands/bars/InboxCommandBar')
QueueCommandBar   = React.createFactory(require 'ui/screens/workspace/panels/card/commands/bars/QueueCommandBar')
TrashCommandBar   = React.createFactory(require 'ui/screens/workspace/panels/card/commands/bars/TrashCommandBar')

CardCommandBar = React.createClass {

  displayName: 'CardCommandBar'

  propTypes:
    card:  PropTypes.Card
    stack: PropTypes.Stack

  render: ->

    if @props.card.status == CardStatus.Complete
      CommandBar = ArchiveCommandBar
    else if @props.card.status == CardStatus.Deleted
      CommandBar = TrashCommandBar
    else
      CommandBar = @getCommandBarClassByStackType()

    CommandBar {card: @props.card, stack: @props.stack}

  getCommandBarClassByStackType: ->
    switch @props.stack.type
      when StackType.Backlog then BacklogCommandBar
      when StackType.Drafts  then DraftsCommandBar
      when StackType.Inbox   then InboxCommandBar
      when StackType.Queue   then QueueCommandBar

}

module.exports = CardCommandBar
