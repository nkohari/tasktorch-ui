React         = require 'react'
Router        = require 'react-router'
Api           = require '../../Api'
Strings       = require '../../Strings'
Panel         = require '../../common/Panel'
Flux          = require '../../mixins/Flux'
ActiveUrl     = require '../../mixins/ActiveUrl'
WorkspaceUrl  = require '../WorkspaceUrl'
CardActionBar = require './CardActionBar'
CardHeader    = require './CardHeader'
CardBody      = require './CardBody'

CardPanel = React.createClass {

  mixins: [
    Flux('cards')
    ActiveUrl(WorkspaceUrl)
  ]

  propTypes:
    cardId: React.PropTypes.string.isRequired

  getStateFromStores: (stores) ->
    return {
      card: stores.cards.getCard(@props.cardId) ? {}
    }

  componentWillMount: ->
    @getController().loadCard(@props.cardId)

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
    url = @getActiveUrl()
    url.removeCard(@props.cardId)
    return url.makeLinkProps()

}

module.exports = CardPanel
