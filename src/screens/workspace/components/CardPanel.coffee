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

CardPanel = React.createClass {

  displayName: 'CardPanel'

  mixins: [
    Flux('cards')
    ActiveUrl(WorkspaceUrl)
  ]

  propTypes:
    cardId: React.PropTypes.string.isRequired

  getStateFromStores: (stores) ->
    card = stores.cards.getCard(@props.cardId)
    type = stores.types.getType(card.type) if card?
    return {
      card: card ? {}
      type: type ? {}
    }

  componentWillMount: ->
    @getController().loadCard(@props.cardId)

  render: ->
    Panel {
      style:      {zIndex: 99 - @props.position}
      panelTitle: @state.card.title or Constants.untitledCard
      icon:       'card'
      className:  'card'
      close:      @makeCloseLinkProps()
    }, [
      CardActionBar {key: 'card-actions', card: @state.card}
      CardHeader {key: 'card-header', card: @state.card, type: @state.type}
      CardBody {key: 'card-body', card: @state.card}
    ]

  makeCloseLinkProps: ->
    url = @getActiveUrl()
    url.removeCard(@props.cardId)
    return url.makeLinkProps()

}

module.exports = CardPanel
