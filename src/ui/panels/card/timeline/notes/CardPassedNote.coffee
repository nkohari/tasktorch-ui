_           = require 'lodash'
React       = require 'react'
PropTypes   = require 'ui/framework/PropTypes'
CachedState = require 'ui/framework/mixins/CachedState'
Frame       = React.createFactory(require 'ui/common/Frame')
Icon        = React.createFactory(require 'ui/common/Icon')
Time        = React.createFactory(require 'ui/common/Time')
TeamWidget  = React.createFactory(require 'ui/panels/card/timeline/widgets/TeamWidget')
UserWidget  = React.createFactory(require 'ui/panels/card/timeline/widgets/UserWidget')
{div}       = React.DOM

CardPassedNote = React.createClass {

  displayName: 'CardPassedNote'

  propTypes:
    card: PropTypes.Card
    note: PropTypes.Note
    user: PropTypes.User

  mixins: [CachedState]

  getCachedState: (cache) -> {
    receivingUser: cache('users').get(@props.note.content.to.user) if @props.note.content.to.user?
    receivingTeam: cache('teams').get(@props.note.content.to.team) if @props.note.content.to.team?
  }

  isReady: ->
    @state.receivingUser? or @state.receivingTeam?

  render: ->

    if @state.receivingUser?
      recipient = UserWidget {user: @state.receivingUser}
    else if @state.receivingTeam?
      recipient = TeamWidget {team: @state.receivingTeam}

    Frame {@isReady, className: 'activity'},
      Icon {className: 'activity-icon', name: 'pass'}
      div {className: 'activity-body'},
        UserWidget {user: @props.user}
        'passed the card to'
        recipient
        Time {relative: true, time: @props.note.time}

}

module.exports = CardPassedNote
