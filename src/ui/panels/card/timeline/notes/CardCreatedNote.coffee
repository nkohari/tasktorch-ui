_          = require 'lodash'
React      = require 'react'
PropTypes  = require 'ui/framework/PropTypes'
Icon       = React.createFactory(require 'ui/common/Icon')
Time       = React.createFactory(require 'ui/common/Time')
UserWidget = React.createFactory(require 'ui/panels/card/timeline/widgets/UserWidget')
{div}      = React.DOM

CardCreatedNote = React.createClass {

  displayName: 'CardCreatedNote'

  propTypes:
    card: PropTypes.Card
    note: PropTypes.Note
    user: PropTypes.User

  render: ->

    div {className: 'activity'},
      Icon {className: 'activity-icon', name: 'create-card'}
      div {className: 'activity-body'},
        UserWidget {user: @props.user}
        'created the card'
        Time {relative: true, time: @props.note.time}

}

module.exports = CardCreatedNote
