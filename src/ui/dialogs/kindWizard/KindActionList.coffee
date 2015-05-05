_                  = require 'lodash'
React              = require 'react'
PropTypes          = require 'ui/framework/PropTypes'
SortableList       = require 'ui/framework/mixins/SortableList'
KindActionListItem = React.createFactory(require 'ui/dialogs/kindWizard/KindActionListItem')
{div, li, ul}      = React.DOM

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
    }
  ]

  render: ->

    items = _.map @props.stage.actions, (action) =>
      KindActionListItem {key: action.id, stage: @props.stage, action, updateAction: @props.updateAction, removeAction: @props.removeAction}

    ul {className: 'kind-action-list'}, items

  getSortableList: ->
    @props.stage

  getSortableListItem: (id) ->
    _.find @props.stage.actions, (action) -> action.id == id

  onMove: (action, toStage, toPosition) ->

  onReorder: (stage, toPosition) ->

  onListOrderChanged: (ids) ->
    actions = _.map ids, (id) => @getSortableListItem(id)
    @props.setActions(@props.stage.id, actions)

  isDropAllowed: (card, fromStack) ->
    return true

}

module.exports = KindActionList