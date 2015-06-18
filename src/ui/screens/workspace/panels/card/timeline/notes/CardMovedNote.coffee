#--------------------------------------------------------------------------------
_            = require 'lodash'
React        = require 'react'
PropTypes    = require 'ui/framework/PropTypes'
CachedState  = require 'ui/framework/mixins/CachedState'
Icon         = React.createFactory(require 'ui/common/Icon')
Time         = React.createFactory(require 'ui/common/Time')
ActivityNote = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/notes/ActivityNote')
UserWidget   = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/widgets/UserWidget')
StackWidget  = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/widgets/StackWidget')
{div}        = React.DOM
#--------------------------------------------------------------------------------

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

    ActivityNote {@isReady, icon: 'move'},
      UserWidget {user: @props.user}
      'moved the card to'
      StackWidget {stack: @state.stack}
      Time {relative: true, time: @props.note.created}

}

module.exports = CardMovedNote
