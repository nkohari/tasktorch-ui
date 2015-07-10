#--------------------------------------------------------------------------------
_                       = require 'lodash'
React                   = require 'react'
SortableMixin           = require 'sortablejs/react-sortable-mixin'
compare                 = require 'common/util/compare'
UserMovedStageEvent     = require 'events/ui/UserMovedStageEvent'
PropTypes               = require 'ui/framework/PropTypes'
Actor                   = require 'ui/framework/mixins/Actor'
ChangeKindWorkflowStage = React.createFactory(require 'ui/dialogs/changeKindWorkflow/ChangeKindWorkflowStage')
{ul, li}                = React.DOM
#--------------------------------------------------------------------------------
require './ChangeKindWorkflowStageList.styl'
#--------------------------------------------------------------------------------

ChangeKindWorkflowStageList = React.createClass {

  displayEmail: 'ChangeKindWorkflowStageList'

  propTypes:
    kind:   PropTypes.Kind
    stages: PropTypes.arrayOf(PropTypes.Stage)

  mixins: [Actor, SortableMixin]

  sortableOptions:
    group: 'stages'
    model: 'stages'

  getInitialState: ->
    {stages: @props.stages, dirty: false}

  componentWillReceiveProps: (newProps) ->
    if not @state.dirty
      @setState {stages: newProps.stages}
    else if not compare.arrays(newProps.stages, @props.stages)
      @setState {stages: newProps.stages, dirty: false}

  render: ->

    items = _.map @state.stages, (stage) =>
      ChangeKindWorkflowStage {key: stage.id, stage}

    ul {className: 'change-kind-workflow-stage-list'},
      items

  handleUpdate: (event) ->
    stageid = event.item.getAttribute('data-itemid')
    @setState {dirty: true}
    @publish new UserMovedStageEvent(stageid, event.newIndex)

}

module.exports = ChangeKindWorkflowStageList
