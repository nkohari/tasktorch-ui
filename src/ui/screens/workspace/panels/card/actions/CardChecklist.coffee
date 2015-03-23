_                       = require 'lodash'
React                   = require 'react'
PropTypes               = require 'ui/framework/PropTypes'
CachedState             = require 'ui/framework/mixins/CachedState'
CardChecklistActionList = React.createFactory(require 'ui/screens/workspace/panels/card/actions/CardChecklistActionList')
CreateActionForm        = React.createFactory(require 'ui/screens/workspace/panels/card/actions/CreateActionForm')
{div}                   = React.DOM

CardChecklist = React.createClass {

  displayName: 'CardChecklist'

  propTypes:
    card:      PropTypes.Card
    checklist: PropTypes.Checklist
    stage:     PropTypes.Stage

  mixins: [CachedState]

  getCachedState: (cache) -> {
    actions: cache('actionsByChecklist').get(@props.checklist.id)
  }

  render: ->

    div {className: 'card-checklist'},
      div {className: 'title'}, @props.stage.name
      CardChecklistActionList {checklist: @props.checklist, actions: @state.actions}
      CreateActionForm {checklist: @props.checklist}

}

module.exports = CardChecklist
