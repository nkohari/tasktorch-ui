#--------------------------------------------------------------------------------
_            = require 'lodash'
React        = require 'react'
PropTypes    = require 'ui/framework/PropTypes'
CachedState  = require 'ui/framework/mixins/CachedState'
Icon         = React.createFactory(require 'ui/common/Icon')
Time         = React.createFactory(require 'ui/common/Time')
ActivityNote = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/notes/ActivityNote')
ActionWidget = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/widgets/ActionWidget')
CardWidget   = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/widgets/CardWidget')
StageWidget  = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/widgets/StageWidget')
UserWidget   = React.createFactory(require 'ui/screens/workspace/panels/card/timeline/widgets/UserWidget')
{div}        = React.DOM
#--------------------------------------------------------------------------------

ActionMovedNote = React.createClass {

  displayName: 'ActionMovedNote'

  propTypes:
    card: PropTypes.Card
    note: PropTypes.Note
    user: PropTypes.User

  mixins: [CachedState]

  getCachedState: (cache) -> {
    action:    cache('actions').get(@props.note.content.action)
    fromCard:  cache('cards').get(@props.note.content.from.card)
    fromStage: cache('stages').get(@props.note.content.from.stage)
    toStage:   cache('stages').get(@props.note.content.to.stage)
  }

  isReady: ->
    @state.action?

  render: ->

    {from, to} = @props.note.content

    if from.card == to.card and from.stage == to.stage
      @renderMoveWithinStage()
    else if from.card == to.card
      @renderMoveBetweenStages()
    else
      @renderMoveBetweenCards()

  renderMoveWithinStage: ->

    ActivityNote {@isReady, icon: 'action'},
      UserWidget {user: @props.user}
      'moved the action'
      ActionWidget {action: @state.action}
      'within'
      StageWidget {stage: @state.fromStage}
      Time {relative: true, time: @props.note.created}

  renderMoveBetweenStages: ->

    ActivityNote {@isReady, icon: 'action'},
      UserWidget {user: @props.user}
      'moved the action'
      ActionWidget {action: @state.action}
      'from'
      StageWidget {stage: @state.fromStage}
      'to'
      StageWidget {stage: @state.toStage}
      Time {relative: true, time: @props.note.created}

  renderMoveBetweenCards: ->

    ActivityNote {@isReady, icon: 'action'},
      UserWidget {user: @props.user}
      'moved the action'
      ActionWidget {action: @state.action}
      'from'
      StageWidget {stage: @state.fromStage}
      'of card'
      CardWidget {stage: @state.fromCard}
      'to'
      StageWidget {stage: @state.toStage}
      Time {relative: true, time: @props.note.created}

}

module.exports = ActionMovedNote
