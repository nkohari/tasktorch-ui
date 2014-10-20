React              = require 'react'
Router             = require 'react-router'
Api                = require '../Api'
Bus                = require '../Bus'
Strings            = require '../Strings'
Panel              = require '../common/Panel'
WorkspaceViewState = require './WorkspaceViewState'
CardActionBar      = require './CardActionBar'
CardHeader         = require './CardHeader'
CardBody           = require './CardBody'

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

  componentWillUnmount: ->
    Bus.cards.subscribe(this)

  render: ->
    Panel {
      style:      {zIndex: 99 - @props.position}
      panelTitle: @state.card.title or Strings.untitledCard
      className:  'card'
      close:      @makeCloseLinkProps()
    }, [
      CardActionBar {card: @state.card}
      CardHeader {card: @state.card}
      CardBody {card: @state.card}
    ]

  makeCloseLinkProps: ->
    viewState = new WorkspaceViewState(this)
    viewState.removeCard(@props.cardId)
    return viewState.makeLinkProps()

  dataDidChange: (card) ->
    @setState {card} if @state.card.id == card.id

}

module.exports = CardPanel
