_           = require 'lodash'
React       = require 'react'
PropTypes   = require 'ui/framework/PropTypes'
CachedState = require 'ui/framework/mixins/CachedState'
StageCard   = React.createFactory(require 'ui/screens/bigPicture/panels/kind/StageCard')
{div, ul}   = React.DOM

StageColumn = React.createClass {

  displayName: 'StageColumn'

  propTypes:
    stage: PropTypes.Stage

  mixins: [CachedState]

  getCachedState: (cache) -> {
    cards: cache('cardsByStage').get(@props.stage.id)
  }

  render: ->

    count  = @state.cards?.length or 0
    plural = if count == 1 then '' else 's'

    cards = _.map @state.cards, (card) =>
      StageCard {key: card.id, stage: @props.stage, card}

    div {className: 'big-picture-column'},
      div {className: 'header'},
        div {className: 'content'},
          div {className: 'name'}, @props.stage.name
          div {className: 'count'}, "#{count} card#{plural}"
      ul {className: 'cards'}, cards

}

module.exports = StageColumn
