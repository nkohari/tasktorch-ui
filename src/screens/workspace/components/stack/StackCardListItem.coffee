React        = require 'react/addons'
Router       = require 'react-router'
StackType    = require 'framework/enums/StackType'
WorkspaceUrl = require 'framework/urls/WorkspaceUrl'
Observe      = require 'mixins/Observe'
Frame        = React.createFactory(require 'common/Frame')
QueueCard    = React.createFactory(require './cards/QueueCard')
InboxCard    = React.createFactory(require './cards/InboxCard')
DraftsCard   = React.createFactory(require './cards/DraftsCard')
BacklogCard  = React.createFactory(require './cards/BacklogCard')
{li}         = React.DOM
{classSet}   = React.addons

StackCardListItem = React.createClass {

  displayName: 'StackCardListItem'

  mixins: [
    Observe('kinds')
    Router.Navigation
    Router.State
  ]

  sync: (stores) ->
    {kind: stores.kinds.get(@props.card.kind)}

  isReady: ->
    @state.kind?

  render: ->

    classes = 
      'stack-card': true
      active:       new WorkspaceUrl(this).isCardActive(@props.card.id)

    Frame {
      @isReady
      component:     'li'
      className:     classSet(classes)
      onClick:       @handleClick
      'data-itemid': @props.card.id
    }, [@renderContents()]

  renderContents: ->
    switch @props.stack.type
      when StackType.Queue
        return QueueCard {stack: @props.stack, card: @props.card, kind: @state.kind}
      when StackType.Inbox
        return InboxCard {stack: @props.stack, card: @props.card, kind: @state.kind}
      when StackType.Drafts
        return DraftsCard {stack: @props.stack, card: @props.card, kind: @state.kind}
      when StackType.Backlog
        return BacklogCard {stack: @props.stack, card: @props.card, kind: @state.kind}

  handleClick: ->
    url = new WorkspaceUrl(this)
    url.addCardAfter(@props.card.id, @props.stack.id)
    props = url.makeLinkProps()
    @transitionTo(props.to, props.params, props.query)

}

module.exports = StackCardListItem
