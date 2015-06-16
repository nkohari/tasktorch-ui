_          = require 'lodash'
React      = require 'react'
PropTypes  = require 'ui/framework/PropTypes'
Icon       = React.createFactory(require 'ui/common/Icon')
Time       = React.createFactory(require 'ui/common/Time')
UserWidget = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/widgets/UserWidget')
{div}      = React.DOM

CardAcceptedNote = React.createClass {

  displayName: 'CardAcceptedNote'

  propTypes:
    card: PropTypes.Card
    note: PropTypes.Note
    user: PropTypes.User

  render: ->

    div {className: 'activity'},
      Icon {className: 'activity-icon', name: 'accept'}
      div {className: 'activity-body'},
        UserWidget {user: @props.user}
        'accepted the card'
        Time {relative: true, time: @props.note.created}

}

module.exports = CardAcceptedNote
