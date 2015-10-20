#--------------------------------------------------------------------------------
_                  = require 'lodash'
React              = require 'react'
SortableMixin      = require 'sortablejs/react-sortable-mixin'
classSet           = require 'common/util/classSet'
compare            = require 'common/util/compare'
PropTypes          = require 'ui/framework/PropTypes'
KindActionListItem = React.createFactory(require 'ui/dialogs/kindWizard/KindActionListItem')
{div, li, ul}      = React.DOM
#--------------------------------------------------------------------------------
require './KindActionList.styl'
#--------------------------------------------------------------------------------

KindActionList = React.createClass {

  displayName: 'KindActionList'

  propTypes:
    stage:        PropTypes.object
    setActions:   PropTypes.func
    updateAction: PropTypes.func
    removeAction: PropTypes.func

  mixins: [SortableMixin]

  sortableOptions:
    group: 'kind-actions'
    model: 'actions'

  getInitialState: ->
    {actions: @props.stage.defaultActions, dirty: false}

  componentWillReceiveProps: (newProps) ->
    if not @state.dirty
      @setState {actions: newProps.stage.defaultActions}
    else if not compare.arrays(newProps.stage.defaultActions, @props.stage.defaultActions)
      @setState {actions: newProps.stage.defaultActions, dirty: false}

  render: ->

    items = _.map _.compact(@state.actions), (action, index) =>
      KindActionListItem {key: index, stage: @props.stage, action, updateAction: @props.updateAction, removeAction: @props.removeAction}

    ul {className: 'kind-action-list'}, items

  handleAdd: (event) ->
    @setState {dirty: true}
    @props.setActions(@props.stage.id, @state.actions)

  handleRemove: (event) ->
    @setState {dirty: true}
    @props.setActions(@props.stage.id, @state.actions)

  handleUpdate: (event) ->
    @setState {dirty: true}
    @props.setActions(@props.stage.id, @state.actions)

}

module.exports = KindActionList