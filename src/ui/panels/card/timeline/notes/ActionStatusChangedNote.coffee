_                  = require 'lodash'
React              = require 'react'
PropTypes          = require 'ui/framework/PropTypes'
CachedState        = require 'ui/framework/mixins/CachedState'
Frame              = React.createFactory(require 'ui/common/Frame')
Icon               = React.createFactory(require 'ui/common/Icon')
Time               = React.createFactory(require 'ui/common/Time')
ActionWidget       = React.createFactory(require 'ui/panels/card/timeline/widgets/ActionWidget')
ActionStatusWidget = React.createFactory(require 'ui/panels/card/timeline/widgets/ActionStatusWidget')
UserWidget         = React.createFactory(require 'ui/panels/card/timeline/widgets/UserWidget')
{div, em}          = React.DOM

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

    Frame {@isReady, className: 'activity'},
      Icon {className: 'activity-icon', name: 'action'}
      div {className: 'activity-body'},
        UserWidget {user: @props.user}
        'marked the action'
        ActionWidget {action: @state.action}
        'as'
        ActionStatusWidget {status: @props.note.content.to}
        Time {relative: true, time: @props.note.time}

}

module.exports = ActionStatusChangedNote
