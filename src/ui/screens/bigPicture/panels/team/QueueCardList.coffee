_           = require 'lodash'
React       = require 'react'
PropTypes   = require 'ui/framework/PropTypes'
CachedState = require 'ui/framework/mixins/CachedState'
List        = React.createFactory(require 'ui/common/List')
QueueCard   = React.createFactory(require 'ui/screens/bigPicture/panels/team/QueueCard')

QueueCardList = React.createClass {

  displayName: 'QueueCardList'

  propTypes:
    stack: PropTypes.Stack
    user:  PropTypes.User

  mixins: [CachedState]

  getCachedState: (cache) -> {
    cards: cache('cardsByStack').get(@props.stack.id)
  }

  isReady: ->
    @state.cards?

  render: ->

    items = _.map @state.cards, (card) =>
      QueueCard {
        key:   card.id
        stack: @props.stack
        card:  card
      }

    List {@isReady, className: 'cards'}, items

}

module.exports = QueueCardList
