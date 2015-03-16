_              = require 'lodash'
React          = require 'react'
PropTypes      = require 'ui/framework/PropTypes'
Icon           = React.createFactory(require 'ui/common/Icon')
Time           = React.createFactory(require 'ui/common/Time')
ExpandableDiff = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/ExpandableDiff')
UserWidget     = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/widgets/UserWidget')
{div}          = React.DOM

CardSummaryChangedNote = React.createClass {

  displayName: 'CardSummaryChangedNote'

  propTypes:
    card: PropTypes.Card
    note: PropTypes.Note
    user: PropTypes.User

  render: ->

    div {className: 'activity'},
      Icon {className: 'activity-icon', name: 'edit'}
      div {className: 'activity-body'},
        UserWidget {user: @props.user}
        'changed the summary'
        Time {relative: true, time: @props.note.time}
        ExpandableDiff {from: @props.note.content.from, to: @props.note.content.to}

}

module.exports = CardSummaryChangedNote
