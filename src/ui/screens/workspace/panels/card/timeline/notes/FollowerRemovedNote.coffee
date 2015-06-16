_          = require 'lodash'
React      = require 'react'
PropTypes  = require 'ui/framework/PropTypes'
Icon       = React.createFactory(require 'ui/common/Icon')
Time       = React.createFactory(require 'ui/common/Time')
UserWidget = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/widgets/UserWidget')
{div}      = React.DOM

FollowerRemovedNote = React.createClass {

  displayName: 'FollowerRemovedNote'

  propTypes:
    card: PropTypes.Card
    note: PropTypes.Note
    user: PropTypes.User

  render: ->

    div {className: 'activity'},
      Icon {className: 'activity-icon', name: 'follow-open'}
      div {className: 'activity-body'},
        UserWidget {user: @props.user}
        'stopped following the card'
        Time {relative: true, time: @props.note.created}

}

module.exports = FollowerRemovedNote
