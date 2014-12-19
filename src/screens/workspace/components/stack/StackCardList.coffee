React           = require 'react/addons'
StackType       = require 'framework/enums/StackType'
QueueCardList   = React.createFactory(require './queue/QueueCardList')
InboxCardList   = React.createFactory(require './inbox/InboxCardList')
DraftsCardList  = React.createFactory(require './drafts/DraftsCardList')
BacklogCardList = React.createFactory(require './backlog/BacklogCardList')

StackCardList = React.createClass {

  displayName: 'StackCardList'

  render: ->
    switch @props.stack.type
      when StackType.Queue   then QueueCardList @props
      when StackType.Inbox   then InboxCardList @props
      when StackType.Drafts  then DraftsCardList @props
      when StackType.Backlog then BacklogCardList @props

}

module.exports = StackCardList
