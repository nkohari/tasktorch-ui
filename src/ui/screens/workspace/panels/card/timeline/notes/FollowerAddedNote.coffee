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

FollowerAddedNote = React.createClass {

  displayName: 'FollowerAddedNote'

  propTypes:
    card: PropTypes.Card
    note: PropTypes.Note
    user: PropTypes.User

  render: ->

    ActivityNote {icon: 'follow'},
      UserWidget {user: @props.user}
      'started following the card'
      Time {relative: true, time: @props.note.created}

}

module.exports = FollowerAddedNote
