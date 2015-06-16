_              = require 'lodash'
React          = require 'react'
PropTypes      = require 'ui/framework/PropTypes'
CachedState    = require 'ui/framework/mixins/CachedState'
BigPictureCard = React.createFactory(require 'ui/screens/bigPicture/BigPictureCard')
{div, ul}      = React.DOM

KindPanelColumn = React.createClass {

  displayName: 'KindPanelColumn'

  propTypes:
    kind:  PropTypes.Kind
    stage: PropTypes.Stage

  mixins: [CachedState]

  getCachedState: (cache) -> {
    cards: cache('cardsByStage').get(@props.stage.id)
  }

  render: ->

    count  = @state.cards?.length or 0
    plural = if count == 1 then '' else 's'

    cards = _.map @state.cards, (card) =>
      BigPictureCard {key: card.id, card}

    div {className: 'big-picture-column'},
      div {className: 'header'},
        div {className: 'content'},
          div {className: 'name'}, @props.stage.name
          div {className: 'count'}, "#{count} card#{plural}"
      div {className: 'content'},
        ul {className: 'cards'}, cards

}

module.exports = KindPanelColumn
