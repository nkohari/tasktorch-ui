#--------------------------------------------------------------------------------
_                                   = require 'lodash'
React                               = require 'react'
SortableMixin                       = require 'sortablejs/react-sortable-mixin'
compare                             = require 'common/util/compare'
classSet                            = require 'common/util/classSet'
UserChangedStageDefaultActionsEvent = require 'events/ui/UserChangedStageDefaultActionsEvent'
PropTypes                           = require 'ui/framework/PropTypes'
Actor                               = require 'ui/framework/mixins/Actor'
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

  mixins: [Actor, SortableMixin]

  sortableOptions:
    group: 'kind-actions'
    model: 'actions'

  getInitialState: ->
    {actions: _.clone(@props.stage.defaultActions), dirty: false}

  componentWillReceiveProps: (newProps) ->
    if not @state.dirty
      @setState {actions: newProps.stage.defaultActions}
    else if not compare.arrays(newProps.stage.defaultActions, @props.stage.defaultActions)
      @setState {actions: newProps.stage.defaultActions, dirty: false}

  render: ->

    items = _.map _.compact(@state.actions), (action, index) =>
      li {key: "#{@props.stage.id}-#{index}", 'data-id': index, className: 'change-kind-workflow-action'},
        div {className: 'action-content'},
          EditableTextArea {value: action.text, rows: 1, save: @changeActionText.bind(this, index)}
          a {className: 'delete-action', onClick: @deleteAction.bind(this, index)},
            Icon {name: 'remove'}

    ul {className: 'change-kind-workflow-action-list'}, items

  changeActionText: (index, text) ->
    actions = _.cloneDeep(@state.actions)
    actions[index].text = text
    @setState {actions}
    @publish new UserChangedStageDefaultActionsEvent(@props.stage.id, actions)

  deleteAction: (index) ->
    actions = _.clone(@state.actions)
    actions.splice(index, 1)
    @setState {actions}
    @publish new UserChangedStageDefaultActionsEvent(@props.stage.id, actions)

  handleUpdate: (event) ->
    @setState {dirty: true}
    @publish new UserChangedStageDefaultActionsEvent(@props.stage.id, @state.actions)

  handleAdd: (event) ->
    @setState {dirty: true}
    @publish new UserChangedStageDefaultActionsEvent(@props.stage.id, @state.actions)

  handleRemove: (event) ->
    @setState {dirty: true}
    @publish new UserChangedStageDefaultActionsEvent(@props.stage.id, @state.actions)

}

module.exports = ChangeKindWorkflowActionList
