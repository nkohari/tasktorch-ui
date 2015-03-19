_         = require 'lodash'
React     = require 'react'
PropTypes = require 'ui/framework/PropTypes'
StageCard = React.createFactory(require 'ui/screens/bigPicture/panels/kind/StageCard')
{ul}      = React.DOM

StageCardList = React.createClass {

  displayName: 'StageCardList'

  propTypes:
    stage: PropTypes.Stack
    cards: PropTypes.arrayOf(PropTypes.Card)

  render: ->

    items = _.map @props.cards, (card) =>
      StageCard {
        key:   card.id
        stage: @props.stage
        card:  card
      }

    ul {className: 'cards'}, items

}

module.exports = StageCardList
