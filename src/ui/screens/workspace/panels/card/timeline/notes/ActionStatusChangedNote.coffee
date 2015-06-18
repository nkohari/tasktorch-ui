#--------------------------------------------------------------------------------
_                  = require 'lodash'
React              = require 'react'
PropTypes          = require 'ui/framework/PropTypes'
CachedState        = require 'ui/framework/mixins/CachedState'
Icon               = React.createFactory(require 'ui/common/Icon')
Time               = React.createFactory(require 'ui/common/Time')
ActivityNote       = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/notes/ActivityNote')
ActionWidget       = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/widgets/ActionWidget')
ActionStatusWidget = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/widgets/ActionStatusWidget')
UserWidget         = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/widgets/UserWidget')
{div, em}          = React.DOM
#--------------------------------------------------------------------------------

ActionStatusChangedNote = React.createClass {

  displayName: 'ActionStatusChangedNote'

  propTypes:
    card: PropTypes.Card
    note: PropTypes.Note
    user: PropTypes.User

  mixins: [CachedState]

  getCachedState: (cache) -> {
    action: cache('actions').get(@props.note.content.action)
  }

  isReady: ->
    @state.action?

  render: ->

    ActivityNote {@isReady, icon: 'action'},
      UserWidget {user: @props.user}
      'marked the action'
      ActionWidget {action: @state.action}
      'as'
      ActionStatusWidget {status: @props.note.content.to}
      Time {relative: true, time: @props.note.created}

}

module.exports = ActionStatusChangedNote
