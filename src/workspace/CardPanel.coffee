React = require 'react'
Bus   = require '../Bus'
Panel = require '../common/Panel'

CardPanel = React.createClass {

  getInitialState: ->
    {card: {}}

  componentWillReceiveProps: (newProps) ->
    @setState {card: newProps.card}

  componentWillMount: ->
    @setState {card: @props.card}
    Bus.cards.subscribe(this)

  componentDidMount: ->
    @getDOMNode().scrollIntoView()

  componentWillUnmount: ->
    Bus.cards.subscribe(this)

  render: ->
    style = {zIndex: 99 - @props.position}
    Panel {title: @state.card.title, className: 'card', style, onClose: @handlePanelClose}, [
      @state.card.body
    ]

  handlePanelClose: ->
    Screen.closeCard(@state.card)

  dataDidChange: (card) ->
    @setState {card} if @state.card.id == card.id

}

module.exports = CardPanel
