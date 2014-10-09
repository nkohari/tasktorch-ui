React              = require 'react'
Router             = require 'react-router'
Api                = require '../Api'
Bus                = require '../Bus'
Panel              = require '../common/Panel'
WorkspaceViewState = require './WorkspaceViewState'

CardPanel = React.createClass {

  mixins: [Router.ActiveState, Router.Navigation]

  getInitialState: ->
    {card: {}}

  componentWillReceiveProps: (newProps) ->
    if newProps.card?
      @setState {card: newProps.card}

  componentWillMount: ->
    {organizationId} = @getActiveParams()
    if @props.card?
      @setState {card: @props.card}
    else
      Api.getCard organizationId, @props.cardId, (err, card) =>
        @setState {card}
    Bus.cards.subscribe(this)

  componentDidMount: ->
    @getDOMNode().scrollIntoView()

  componentWillUnmount: ->
    Bus.cards.subscribe(this)

  render: ->
    style = {zIndex: 99 - @props.position}
    Panel {title: @state.card.title, className: 'card', style, close: @makeCloseLinkProps()}, [
      @state.card.body
    ]

  makeCloseLinkProps: ->
    viewState = new WorkspaceViewState(this)
    viewState.removeCard(@props.cardId)
    return viewState.makeLinkProps()

  dataDidChange: (card) ->
    @setState {card} if @state.card.id == card.id

}

module.exports = CardPanel
