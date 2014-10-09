_         = require 'lodash'
React     = require 'react'
Router    = require 'react-router'
Bus       = require '../Bus'
Api       = require '../Api'
Panel     = require '../common/Panel'
StackCard = require './StackCard'
{ul}      = React.DOM

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

    cards = _.map @state.cards, (card) =>
      StackCard {stack: @state.stack, card}

    style = {zIndex: 99 - @props.position}
    Panel {title: @state.stack.name, className: 'stack', style, icon: "stack-#{@state.stack.kind}", onClose: @handlePanelClose}, [
      ul {className: 'card-list'}, cards
    ]

  dataDidChange: (stack) ->
    @setState {stack} if stack.id == @state.stack.id

  handlePanelClose: ->
    Screen.closeStack(@props.stackId)

}

module.exports = StackPanel
