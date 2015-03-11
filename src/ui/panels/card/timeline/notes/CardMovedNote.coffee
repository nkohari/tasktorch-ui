_           = require 'lodash'
React       = require 'react'
PropTypes   = require 'ui/framework/PropTypes'
CachedState = require 'ui/framework/mixins/CachedState'
Frame       = React.createFactory(require 'ui/common/Frame')
Icon        = React.createFactory(require 'ui/common/Icon')
Time        = React.createFactory(require 'ui/common/Time')
UserWidget  = React.createFactory(require 'ui/panels/card/timeline/widgets/UserWidget')
StackWidget = React.createFactory(require 'ui/panels/card/timeline/widgets/StackWidget')
{div}       = React.DOM

CardMovedNote = React.createClass {

  displayName: 'CardMovedNote'

  propTypes:
    card: PropTypes.Card
    note: PropTypes.Note
    user: PropTypes.User

  mixins: [CachedState]

  getCachedState: (cache) -> {
    stack: cache('stacks').get(@props.note.content.to.stack)
  }

  isReady: ->
    @state.stack?

  render: ->

    Frame {@isReady, className: 'activity'},
      Icon {className: 'activity-icon', name: 'edit'}
      div {className: 'activity-body'},
        UserWidget {user: @props.user}
        'moved the card to'
        StackWidget {stack: @state.stack}
        Time {relative: true, time: @props.note.time}

}

module.exports = CardMovedNote
