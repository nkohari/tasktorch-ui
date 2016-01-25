#--------------------------------------------------------------------------------
_                        = require 'lodash'
React                    = require 'react'
classSet                 = require 'common/util/classSet'
ActionStatus             = require 'data/enums/ActionStatus'
UserCreatedActionEvent   = require 'events/ui/UserCreatedActionEvent'
PropTypes                = require 'ui/framework/PropTypes'
Actor                    = require 'ui/framework/mixins/Actor'
CachedState              = require 'ui/framework/mixins/CachedState'
Button                   = React.createFactory(require 'ui/common/Button')
Icon                     = React.createFactory(require 'ui/common/Icon')
OverlayTrigger           = React.createFactory(require 'ui/common/OverlayTrigger')
RepeatableInput          = React.createFactory(require 'ui/common/RepeatableInput')
CardChecklistContextMenu = React.createFactory(require 'ui/overlays/CardChecklistContextMenu')
CardChecklistActionList  = React.createFactory(require 'ui/screens/workspace/panels/card/actions/CardChecklistActionList')
{div, span}              = React.DOM
#--------------------------------------------------------------------------------
require './CardChecklist.styl'
#--------------------------------------------------------------------------------

CardChecklist = React.createClass {

  displayName: 'CardChecklist'

  propTypes:
    card:      PropTypes.Card
    checklist: PropTypes.Checklist
    stage:     PropTypes.Stage

  mixins: [Actor, CachedState]

  getInitialState: ->
    {adding: false}

  getCachedState: (cache) -> {
    actions: cache('actionsByChecklist').get(@props.checklist.id)
  }

  render: ->

    classes = classSet [
      'card-checklist'
      'complete' if _.all(@state.actions, (a) -> a.status == ActionStatus.Complete)
    ]

    div {className: classes},
      div {className: 'header'},
        Icon {name: 'checklist'}
        span {className: 'title'}, @props.stage.name
        OverlayTrigger {overlay: CardChecklistContextMenu {checklist: @props.checklist, @startAdding}},
          Icon {name: 'trigger'}
      CardChecklistActionList {checklist: @props.checklist, actions: @state.actions}
      RepeatableInput {onValue: @createAction, onDone: @stopAdding} if @state.adding

  startAdding: ->
    @setState {adding: true}

  stopAdding: ->
    @setState {adding: false}

  createAction: (text) ->
    @publish new UserCreatedActionEvent(@props.checklist.id, text)

}

module.exports = CardChecklist
