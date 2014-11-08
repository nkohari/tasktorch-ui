React         = require 'react'
Router        = require 'react-router'
Constants     = require 'framework/Constants'
Flux          = require 'mixins/Flux'
ActiveUrl     = require 'mixins/ActiveUrl'
WorkspaceUrl  = require '../WorkspaceUrl'
Panel         = React.createFactory(require 'common/Panel')
CardActionBar = React.createFactory(require './CardActionBar')
CardHeader    = React.createFactory(require './CardHeader')
CardBody      = React.createFactory(require './CardBody')
{div}         = React.DOM

CardPanel = React.createClass {

  displayName: 'CardPanel'

  mixins: [
    Flux('cards', 'types')
    ActiveUrl(WorkspaceUrl)
  ]

  propTypes:
    cardId: React.PropTypes.string.isRequired

  getStateFromStores: (stores) ->
    card = stores.cards.getCard(@props.cardId)
    type = stores.types.getType(card.type) if card?
    {card, type}

  componentWillMount: ->
    @getController().loadCard(@props.cardId)

  render: ->

    if @state.card? and @state.type?
      title = @state.card.title or Constants.untitledCard
      children = [
        CardActionBar {key: 'card-actions', card: @state.card}
        CardHeader {key: 'card-header', card: @state.card, type: @state.type}
        CardBody {key: 'card-body', card: @state.card}
      ]
    else 
      title = 'Loading'
      children = []

    Panel {
      style:      {zIndex: 99 - @props.position}
      panelTitle: title
      icon:       'card'
      className:  'card'
      close:      @makeCloseLinkProps()
    }, children

  makeCloseLinkProps: ->
    url = @getActiveUrl()
    url.removeCard(@props.cardId)
    return url.makeLinkProps()

}

module.exports = CardPanel
