React        = require 'react/addons'
Router       = require 'react-router'
StackType    = require 'framework/enums/StackType'
ActiveUrl    = require 'mixins/ActiveUrl'
Observe      = require 'mixins/Observe'
WorkspaceUrl = require '../../WorkspaceUrl'
QueueCard    = React.createFactory(require './cards/QueueCard')
InboxCard    = React.createFactory(require './cards/InboxCard')
DraftsCard   = React.createFactory(require './cards/DraftsCard')
BacklogCard  = React.createFactory(require './cards/BacklogCard')
{li}         = React.DOM
{classSet}   = React.addons

StackCardListItem = React.createClass {

  displayName: 'StackCardListItem'

  mixins: [
    ActiveUrl(WorkspaceUrl)
    Observe('kinds')
    Router.Navigation
  ]

  sync: (stores) ->
    {kind: stores.kinds.get(@props.card.kind)}

  ready: ->
    {kind: @state.kind?}

  render: ->

    classes = 
      'stack-card': true
      active:       @getActiveUrl().isCardActive(@props.card.id)

    li {
      className:     classSet(classes)
      onClick:       @handleClick
      'data-itemid': @props.card.id
    }, @contents()

  children: ->
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
    url = @getActiveUrl()
    url.addCard(@props.card.id)
    props = url.makeLinkProps()
    @transitionTo(props.to, props.params, props.query)

}

module.exports = StackCardListItem
