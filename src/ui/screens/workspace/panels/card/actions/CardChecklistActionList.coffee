#--------------------------------------------------------------------------------
_                    = require 'lodash'
React                = require 'react'
classSet             = require 'common/util/classSet'
compare              = require 'common/util/compare'
PropTypes            = require 'ui/framework/PropTypes'
Actor                = require 'ui/framework/mixins/Actor'
SortableList         = require 'ui/framework/mixins/SortableList'
UserMovedActionEvent = require 'events/ui/UserMovedActionEvent'
Icon                 = React.createFactory(require 'ui/common/Icon')
CardAction           = React.createFactory(require 'ui/screens/workspace/panels/card/actions/CardAction')
{ul}                 = React.DOM
#--------------------------------------------------------------------------------
require './CardChecklistActionList.styl'
#--------------------------------------------------------------------------------

CardChecklistActionList = React.createClass {

  displayName: 'CardChecklistActionList'

  propTypes:
    actions:   PropTypes.arrayOf(PropTypes.Action)
    checklist: PropTypes.Checklist

  mixins: [
    Actor
    SortableList {
      connectWith: '.card-checklist-action-list'
      idAttribute: 'data-itemid'
      tolerance:   'intersect'
    }
  ]

  getInitialState: -> {
    dragging: false
    ids: _.clone(@props.checklist.actions)
  }

  componentWillReceiveProps: (newProps) ->
    @setState {ids: newProps.checklist.actions}

  render: ->

    lookup = _.indexBy(@props.actions, 'id')
    items = _.map @state.ids, (id) =>
      action = lookup[id]
      return unless action?
      CardAction {key: action.id, action}

    classes = classSet [
      'card-checklist-action-list'
      'dragging' if @state.dragging      
    ]

    ul {className: classes}, items

  getSortableList: ->
    @props.checklist

  getSortableListItem: (id) ->
    _.find @props.actions, (action) -> action.id == id

  onDragStarted: ->
    @setState {dragging: true}

  onDragStopped: ->
    @setState {dragging: false}

  onReorder: (action, toPosition) ->
    @publish new UserMovedActionEvent(action.id, @props.checklist.id, toPosition)

  onMove: (action, toChecklist, toPosition) ->
    @publish new UserMovedActionEvent(action.id, toChecklist.id, toPosition)

  onListOrderChanged: (ids) ->
    @setState {ids}

}

module.exports = CardChecklistActionList
