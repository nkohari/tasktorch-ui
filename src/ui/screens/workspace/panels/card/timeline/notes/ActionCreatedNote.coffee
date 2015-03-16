_            = require 'lodash'
React        = require 'react'
PropTypes    = require 'ui/framework/PropTypes'
CachedState  = require 'ui/framework/mixins/CachedState'
Frame        = React.createFactory(require 'ui/common/Frame')
Icon         = React.createFactory(require 'ui/common/Icon')
Time         = React.createFactory(require 'ui/common/Time')
ActionWidget = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/widgets/ActionWidget')
UserWidget   = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/widgets/UserWidget')
{div}        = React.DOM

ActionCreatedNote = React.createClass {

  displayName: 'ActionCreatedNote'

  propTypes:
    card: PropTypes.Card
    note: PropTypes.Note
    user: PropTypes.User

  mixins: [CachedState]

  getInitialState: ->
    {expanded: false}

  getCachedState: (cache) -> {
    action: cache('actions').get(@props.note.content.action)
  }

  isReady: ->
    @state.action?

  render: ->

    Frame {@isReady, className: 'activity'},
      Icon {className: 'activity-icon', name: 'action'}
      div {className: 'activity-body'},
        UserWidget {user: @props.user}
        'created the action'
        ActionWidget {action: @state.action}
        Time {relative: true, time: @props.note.time}

}

module.exports = ActionCreatedNote
