#--------------------------------------------------------------------------------
_                       = require 'lodash'
React                   = require 'react'
compare                 = require 'common/util/compare'
UserMovedStageEvent     = require 'events/ui/UserMovedStageEvent'
PropTypes               = require 'ui/framework/PropTypes'
Actor                   = require 'ui/framework/mixins/Actor'
SortableList            = require 'ui/framework/mixins/SortableList'
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

  mixins: [
    Actor
    SortableList {idAttribute: 'data-itemid'}
  ]

  getInitialState: ->
    {ids: _.pluck(@props.stages, 'id')}

  componentWillReceiveProps: (newProps) ->
    unless compare.hashes(@props, newProps)
      @setState {ids: _.clone(newProps.kind.stages)}

  render: ->

    if @props.stages?
      lookup = _.indexBy(@props.stages, 'id')
      items = _.map @state.ids, (stageid, index) =>
        stage = lookup[stageid]
        return unless stage?
        ChangeKindWorkflowStage {key: stageid, stage}

    ul {className: 'change-kind-workflow-stage-list'},
      items

  getSortableList: ->
    @props.kind

  getSortableListItem: (id) ->
    _.find @props.stages, (stage) -> stage.id == id

  onReorder: (stage, position) ->
    @publish new UserMovedStageEvent(stage.id, position)

  onListOrderChanged: (ids) ->
    @setState {ids}

}

module.exports = ChangeKindWorkflowStageList
