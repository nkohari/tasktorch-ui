#--------------------------------------------------------------------------------
_                        = require 'lodash'
React                    = require 'react'
PropTypes                = require 'ui/framework/PropTypes'
CachedState              = require 'ui/framework/mixins/CachedState'
Button                   = React.createFactory(require 'ui/common/Button')
Icon                     = React.createFactory(require 'ui/common/Icon')
OverlayTrigger           = React.createFactory(require 'ui/common/OverlayTrigger')
CardChecklistContextMenu = React.createFactory(require 'ui/overlays/CardChecklistContextMenu')
CardChecklistActionList  = React.createFactory(require 'ui/screens/workspace/panels/card/actions/CardChecklistActionList')
CreateActionForm         = React.createFactory(require 'ui/screens/workspace/panels/card/actions/CreateActionForm')
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

  mixins: [CachedState]

  getInitialState: ->
    {adding: false}

  getCachedState: (cache) -> {
    actions: cache('actionsByChecklist').get(@props.checklist.id)
  }

  render: ->

    div {className: 'card-checklist'},
      div {className: 'header'},
        Icon {name: 'checklist'}
        span {className: 'title'}, @props.stage.name
        OverlayTrigger {overlay: CardChecklistContextMenu {checklist: @props.checklist, @toggleAdding}},
          Icon {name: 'trigger'}
      CardChecklistActionList {checklist: @props.checklist, actions: @state.actions}
      CreateActionForm {checklist: @props.checklist, @toggleAdding} if @state.adding

  toggleAdding: ->
    @setState {adding: !@state.adding}

}

module.exports = CardChecklist
