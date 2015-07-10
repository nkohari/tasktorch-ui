#--------------------------------------------------------------------------------
_                                   = require 'lodash'
React                               = require 'react'
compare                             = require 'common/util/compare'
classSet                            = require 'common/util/classSet'
UserChangedStageDefaultActionsEvent = require 'events/ui/UserChangedStageDefaultActionsEvent'
PropTypes                           = require 'ui/framework/PropTypes'
Actor                               = require 'ui/framework/mixins/Actor'
SortableList                        = require 'ui/framework/mixins/SortableList'
EditableTextArea                    = React.createFactory(require 'ui/common/EditableTextArea')
Icon                                = React.createFactory(require 'ui/common/Icon')
{a, div, ul, li}                    = React.DOM
#--------------------------------------------------------------------------------
require './ChangeKindWorkflowActionList.styl'
#--------------------------------------------------------------------------------

ChangeKindWorkflowActionList = React.createClass {

  displayEmail: 'ChangeKindWorkflowActionList'

  propTypes:
    stage: PropTypes.Stage

  mixins: [
    Actor
    SortableList {
      idAttribute: 'data-itemid'
      connectWith: '.change-kind-workflow-action-list'
    }
  ]

  getInitialState: ->
    {actions: _.cloneDeep(@props.stage.defaultActions)}

  componentWillReceiveProps: (newProps) ->
    console.log "#{@props.stage.name} componentWillReceiveProps(): %o", newProps
    unless compare.values(@props.stage, newProps.stage)
      actions = _.cloneDeep(newProps.stage.defaultActions)
      console.log "#{@props.stage.name} will update, actions now %o", actions
      @setState {actions}
    else
      console.log "#{@props.stage.name} will NOT update, actions remain %o", @state.actions

  render: ->

    items = _.map @state.actions, (action, index) =>
      li {key: "#{@props.stage.id}-#{index}", 'data-itemid': index, className: 'change-kind-workflow-action'},
        div {className: 'action-content'},
          EditableTextArea {value: action.text, rows: 1, save: @changeActionText.bind(this, index)}
          a {className: 'delete-action', onClick: @deleteAction.bind(this, index)},
            Icon {name: 'remove'}

    ul {className: 'change-kind-workflow-action-list'}, items

  getSortableList: ->
    @props.stage

  getSortableListItem: (index) ->
    @state.actions[index]

  onReceiveListItem: (action, stage, index) ->
    actions = _.cloneDeep(@state.actions)
    actions.splice(index, 0, action)
    console.log "#{@props.stage.name} onReceiveListItem %o", actions
    @setState {actions}
    @publish new UserChangedStageDefaultActionsEvent(@props.stage.id, actions)

  onRemoveListItem: (action, index) ->
    actions = _.cloneDeep(@state.actions)
    actions.splice(index, 1)
    console.log "#{@props.stage.name} onRemoveListItem %o", actions
    @setState {actions}
    @publish new UserChangedStageDefaultActionsEvent(@props.stage.id, actions)

  onReorder: (action, index, previousIndex) ->
    actions = _.cloneDeep(@state.actions)
    actions.splice(previousIndex, 1)
    actions.splice(index, 0, action)
    console.log "#{@props.stage.name} onReorder %o", actions
    @setState {actions}
    @publish new UserChangedStageDefaultActionsEvent(@props.stage.id, actions)

  changeActionText: (index, text) ->
    actions = _.cloneDeep(@state.actions)
    actions[index].text = text
    @setState {actions}
    @publish new UserChangedStageDefaultActionsEvent(@props.stage.id, actions)

  deleteAction: (index) ->
    actions = _.cloneDeep(@state.actions)
    actions.splice(index, 1)
    @setState {actions}
    @publish new UserChangedStageDefaultActionsEvent(@props.stage.id, actions)

}

module.exports = ChangeKindWorkflowActionList
