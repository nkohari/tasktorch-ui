#--------------------------------------------------------------------------------
_                  = require 'lodash'
React              = require 'react'
classSet           = require 'common/util/classSet'
PropTypes          = require 'ui/framework/PropTypes'
SortableList       = require 'ui/framework/mixins/SortableList'
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

  mixins: [
    SortableList {
      idAttribute: 'data-itemid'
      connectWith: '.kind-action-list'
      tolerance:   'intersect'
    }
  ]

  getInitialState: ->
    {dragging: false}

  render: ->

    items = _.map @props.stage.defaultActions, (action) =>
      KindActionListItem {key: action.id, stage: @props.stage, action, updateAction: @props.updateAction, removeAction: @props.removeAction}

    classes = [
      'kind-action-list'
      'dragging' if @state.dragging
    ]

    ul {className: 'kind-action-list'}, items

  getSortableList: ->
    @props.stage

  getSortableListItem: (id) ->
    _.find @props.stage.defaultActions, (action) -> action.id == id

  onDragStarted: ->
    @setState {dragging: true}

  onDragStopped: ->
    @setState {dragging: false}

  onReceiveListItem: (action, toStage, toPosition) ->
    actions = _.cloneDeep(@props.stage.defaultActions)
    actions.splice(toPosition, 0, action)
    @props.setActions(@props.stage.id, actions)

  onListOrderChanged: (ids) ->
    actions = _.compact _.map ids, (id) => @getSortableListItem(id)
    @props.setActions(@props.stage.id, actions)

}

module.exports = KindActionList