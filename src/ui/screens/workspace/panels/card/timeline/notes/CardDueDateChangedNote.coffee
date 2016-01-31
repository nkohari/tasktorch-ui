#--------------------------------------------------------------------------------
_              = require 'lodash'
React          = require 'react'
dateTime       = require 'common/util/dateTime'
PropTypes      = require 'ui/framework/PropTypes'
Icon           = React.createFactory(require 'ui/common/Icon')
Time           = React.createFactory(require 'ui/common/Time')
ActivityNote   = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/notes/ActivityNote')
ExpandableDiff = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/ExpandableDiff')
UserWidget     = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/widgets/UserWidget')
{div}          = React.DOM
#--------------------------------------------------------------------------------

CardDueDateChangedNote = React.createClass {

  displayName: 'CardDueDateChangedNote'

  propTypes:
    card: PropTypes.Card
    note: PropTypes.Note
    user: PropTypes.User

  render: ->

    from = dateTime.format(@props.note.content.from, 'D MMM YYYY?')
    to   = dateTime.format(@props.note.content.from, 'D MMM YYYY?')

    ActivityNote {@isReady, icon: 'edit'},
      UserWidget {user: @props.user}
      'changed the due date'
      Time {relative: true, time: @props.note.created}
      ExpandableDiff {from, to}

}

module.exports = CardDueDateChangedNote
