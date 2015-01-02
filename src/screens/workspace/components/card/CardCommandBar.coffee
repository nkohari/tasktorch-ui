React             = require 'react'
PropTypes         = require 'common/PropTypes'
CardStatus        = require 'framework/enums/CardStatus'
StackType         = require 'framework/enums/StackType'
ArchiveCommandBar = React.createFactory(require './commandBars/ArchiveCommandBar')
BacklogCommandBar = React.createFactory(require './commandBars/BacklogCommandBar')
DraftsCommandBar  = React.createFactory(require './commandBars/DraftsCommandBar')
InboxCommandBar   = React.createFactory(require './commandBars/InboxCommandBar')
QueueCommandBar   = React.createFactory(require './commandBars/QueueCommandBar')
TrashCommandBar   = React.createFactory(require './commandBars/TrashCommandBar')

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
