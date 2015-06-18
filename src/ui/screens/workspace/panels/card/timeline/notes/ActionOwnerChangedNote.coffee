#--------------------------------------------------------------------------------
_            = require 'lodash'
React        = require 'react'
PropTypes    = require 'ui/framework/PropTypes'
CachedState  = require 'ui/framework/mixins/CachedState'
Icon         = React.createFactory(require 'ui/common/Icon')
Time         = React.createFactory(require 'ui/common/Time')
ActivityNote = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/notes/ActivityNote')
ActionWidget = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/widgets/ActionWidget')
UserWidget   = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/widgets/UserWidget')
{div}        = React.DOM
#--------------------------------------------------------------------------------

ActionOwnerChangedNote = React.createClass {

  displayName: 'ActionOwnerChangedNote'

  propTypes:
    card: PropTypes.Card
    note: PropTypes.Note
    user: PropTypes.User

  mixins: [CachedState]

  getInitialState: ->
    {expanded: false}

  getCachedState: (cache) -> {
    action:        cache('actions').get(@props.note.content.action)
    previousOwner: cache('users').get(@props.note.content.from) if @props.note.content.from?
    newOwner:      cache('users').get(@props.note.content.to)   if @props.note.content.to?
  }

  isReady: ->
    @state.action? and (@state.previousOwner? or not @props.note.content.from?) and (@state.newOwner? or not @props.note.content.to?)

  render: ->

    ActivityNote {@isReady, icon: 'action'},
      UserWidget {user: @props.user}
      'changed the owner of action'
      ActionWidget {action: @state.action}
      'from'
      UserWidget {user: @state.previousOwner}
      'to'
      UserWidget {user: @state.newOwner}
      Time {relative: true, time: @props.note.created}

}

module.exports = ActionOwnerChangedNote
