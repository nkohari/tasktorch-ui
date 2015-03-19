_                  = require 'lodash'
React              = require 'react'
PropTypes          = require 'ui/framework/PropTypes'
CachedState        = require 'ui/framework/mixins/CachedState'
Avatar             = React.createFactory(require 'ui/common/Avatar')
Frame              = React.createFactory(require 'ui/common/Frame')
QueueCardList      = React.createFactory(require 'ui/screens/bigPicture/panels/team/QueueCardList')
CSSTransitionGroup = React.createFactory(React.addons.CSSTransitionGroup)
{div}              = React.DOM

QueueColumn = React.createClass {

  displayName: 'QueueColumn'

  propTypes:
    user: PropTypes.User

  mixins: [CachedState]

  getCachedState: (cache) -> {
    stack: cache('queueByUser').get(@props.user.id)
  }

  isReady: ->
    @state.stack?

  render: ->

    count  = @state.stack?.cards.length or 0
    plural = if count == 1 then '' else 's'

    Frame {@isReady, className: 'queue-column'},
      Frame {className: 'header'},
        Avatar {user: @props.user}
        div {className: 'name'}, @props.user.name
        div {className: 'count'}, "#{count} card#{plural} in queue"
      QueueCardList {user: @props.user, stack: @state.stack}

}

module.exports = QueueColumn
