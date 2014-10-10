_                  = require 'lodash'
React              = require 'react'
Router             = require 'react-router'
Bus                = require '../Bus'
Api                = require '../Api'
Panel              = require '../common/Panel'
StackCardFrame     = require './StackCardFrame'
WorkspaceViewState = require './WorkspaceViewState'
{ul}               = React.DOM

StackPanel = React.createClass {

  mixins: [Router.ActiveState],

  getInitialState: ->
    {stack: {}}

  componentWillReceiveProps: (newProps) ->
    @loadCards(newProps.stackId)

  componentWillMount: ->
    @loadCards(@props.stackId)
    Bus.stacks.subscribe(this)

  componentWillUnmount: ->
    Bus.stacks.unsubscribe(this)

  loadCards: (stackId) ->
    {organizationId} = @getActiveParams()
    Api.getStack organizationId, stackId, (err, stack) =>
      @setState {stack}

  render: ->

    cards = _.map @state.stack.cards, (card) =>
      StackCardFrame {stack: @state.stack, cardId: card.id, card}

    style = {zIndex: 99 - @props.position}
    Panel {panelTitle: @state.stack.name, className: 'stack', style, icon: "stack-#{@state.stack.kind}", close: @makeCloseLinkProps()}, [
      ul {className: 'card-list'}, cards
    ]

  makeCloseLinkProps: ->
    viewState = new WorkspaceViewState(this)
    viewState.removeStack(@state.stack.id)
    return viewState.makeLinkProps()

  dataDidChange: (stack) ->
    @setState {stack} if stack.id == @state.stack.id

  handlePanelClose: ->
    Screen.closeStack(@props.stackId)

}

module.exports = StackPanel
