React           = require 'react/addons'
StackType       = require 'framework/enums/StackType'
BacklogCardList = React.createFactory(require './backlog/BacklogCardList')
InboxCardList   = React.createFactory(require './inbox/InboxCardList')
QueueCardList   = React.createFactory(require './queue/QueueCardList')

StackCardList = React.createClass {

  displayName: 'StackCardList'

  render: ->
    switch @props.stack.type
      when StackType.Backlog then BacklogCardList @props
      when StackType.Inbox   then InboxCardList @props
      when StackType.Queue   then QueueCardList @props

}

module.exports = StackCardList
