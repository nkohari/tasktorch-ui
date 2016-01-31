#--------------------------------------------------------------------------------
_            = require 'lodash'
React        = require 'react'
PropTypes    = require 'ui/framework/PropTypes'
Icon         = React.createFactory(require 'ui/common/Icon')
Time         = React.createFactory(require 'ui/common/Time')
ActivityNote = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/notes/ActivityNote')
UserWidget   = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/widgets/UserWidget')
{div, em}    = React.DOM
#--------------------------------------------------------------------------------

CardEffortChangedNote = React.createClass {

  displayName: 'CardEffortChangedNote'

  propTypes:
    card: PropTypes.Card
    note: PropTypes.Note
    user: PropTypes.User

  render: ->

    {from, to} = @props.note.content

    if not from? and to?
      @renderAsSet(to)
    else if from? and not to?
      @renderAsRemove(from)
    else
      @renderAsChange(from, to)

  renderAsSet: (to) ->

    ActivityNote {@isReady, icon: 'edit'},
      UserWidget {user: @props.user}
      'set the effort estimate to'
      em {}, @renderEstimate(to)
      Time {relative: true, time: @props.note.created}

  renderAsRemove: (from) ->

    ActivityNote {@isReady, icon: 'edit'},
      UserWidget {user: @props.user}
      'removed the effort estimate (was'
      em {}, @renderEstimate(from)
      ')'
      Time {relative: true, time: @props.note.created}

  renderAsChange: (from, to) ->

    ActivityNote {@isReady, icon: 'edit'},
      UserWidget {user: @props.user}
      'changed the effort estimate from'
      em {}, @renderEstimate(from)
      'to'
      em {}, @renderEstimate(to)
      Time {relative: true, time: @props.note.created}

  renderEstimate: (est) ->
    "#{est.remaining}h of #{est.total}h complete"

}

module.exports = CardEffortChangedNote
