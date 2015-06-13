_           = require 'lodash'
React       = require 'react'
PropTypes   = require 'ui/framework/PropTypes'
CachedState = require 'ui/framework/mixins/CachedState'
Avatar      = React.createFactory(require 'ui/common/Avatar')
QueueCard   = React.createFactory(require 'ui/screens/bigPicture/panels/team/QueueCard')
{div, ul}   = React.DOM

QueueColumn = React.createClass {

  displayName: 'QueueColumn'

  propTypes:
    user: PropTypes.User

  mixins: [CachedState]

  getCachedState: (cache) ->
    stack = cache('queueByUser').get(@props.user.id)
    cards = cache('cardsByStack').get(stack.id) if stack?
    {stack, cards}

  render: ->

    count  = @state.stack?.cards.length or 0
    plural = if count == 1 then '' else 's'

    cards = _.map @state.cards, (card) =>
      QueueCard {key: card.id, user: @state.user, stack: @state.stack, card}

    div {className: 'big-picture-column'},
      div {className: 'header'},
        Avatar {user: @props.user}
        div {className: 'content'},
          div {className: 'name'},  @props.user.name
          div {className: 'count'}, "#{count} card#{plural} in queue"
      div {className: 'content'},
        ul {className: 'cards'}, cards

}

module.exports = QueueColumn
