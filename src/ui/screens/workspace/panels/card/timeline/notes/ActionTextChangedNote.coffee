_              = require 'lodash'
React          = require 'react'
PropTypes      = require 'ui/framework/PropTypes'
CachedState    = require 'ui/framework/mixins/CachedState'
Frame          = React.createFactory(require 'ui/common/Frame')
Icon           = React.createFactory(require 'ui/common/Icon')
Time           = React.createFactory(require 'ui/common/Time')
ExpandableDiff = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/ExpandableDiff')
ActionWidget   = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/widgets/ActionWidget')
UserWidget     = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/widgets/UserWidget')
{div, em}      = React.DOM

ActionTextChangedNote = React.createClass {

  displayName: 'ActionTextChangedNote'

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
      Icon {className: 'activity-icon', name: 'edit'}
      div {className: 'activity-body'},
        UserWidget {user: @props.user}
        'changed the text of action'
        ActionWidget {action: @state.action}
        Time {relative: true, time: @props.note.time}
        ExpandableDiff {from: @props.note.content.from, to: @props.note.content.to}

}

module.exports = ActionTextChangedNote
