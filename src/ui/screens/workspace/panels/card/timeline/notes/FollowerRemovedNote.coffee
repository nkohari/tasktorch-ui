#--------------------------------------------------------------------------------
_            = require 'lodash'
React        = require 'react'
PropTypes    = require 'ui/framework/PropTypes'
Icon         = React.createFactory(require 'ui/common/Icon')
Time         = React.createFactory(require 'ui/common/Time')
ActivityNote = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/notes/ActivityNote')
UserWidget   = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/widgets/UserWidget')
{div}        = React.DOM
#--------------------------------------------------------------------------------

FollowerRemovedNote = React.createClass {

  displayName: 'FollowerRemovedNote'

  propTypes:
    card: PropTypes.Card
    note: PropTypes.Note
    user: PropTypes.User

  render: ->

    ActivityNote {icon: 'follow-open'},
      UserWidget {user: @props.user}
      'stopped following the card'
      Time {relative: true, time: @props.note.created}

}

module.exports = FollowerRemovedNote
