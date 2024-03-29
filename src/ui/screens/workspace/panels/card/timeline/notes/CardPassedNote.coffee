#--------------------------------------------------------------------------------
_            = require 'lodash'
React        = require 'react'
PropTypes    = require 'ui/framework/PropTypes'
CachedState  = require 'ui/framework/mixins/CachedState'
Icon         = React.createFactory(require 'ui/common/Icon')
Time         = React.createFactory(require 'ui/common/Time')
ActivityNote = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/notes/ActivityNote')
TeamWidget   = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/widgets/TeamWidget')
UserWidget   = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/widgets/UserWidget')
{div}        = React.DOM
#--------------------------------------------------------------------------------

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

    ActivityNote {@isReady, icon: 'pass'},
      UserWidget {user: @props.user}
      'passed the card to'
      recipient
      Time {relative: true, time: @props.note.created}

}

module.exports = CardPassedNote
