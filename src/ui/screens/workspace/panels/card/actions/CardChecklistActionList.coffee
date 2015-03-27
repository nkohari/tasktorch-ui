_                    = require 'lodash'
React                = require 'react'
compare              = require 'common/util/compare'
PropTypes            = require 'ui/framework/PropTypes'
Actor                = require 'ui/framework/mixins/Actor'
SortableList         = require 'ui/framework/mixins/SortableList'
UserMovedActionEvent = require 'events/ui/UserMovedActionEvent'
List                 = React.createFactory(require 'ui/common/List')
ListItem             = React.createFactory(require 'ui/common/ListItem')
Icon                 = React.createFactory(require 'ui/common/Icon')
CardAction           = React.createFactory(require 'ui/screens/workspace/panels/card/actions/CardAction')

CardChecklistActionList = React.createClass {

  displayName: 'CardChecklistActionList'

  propTypes:
    actions:   PropTypes.arrayOf(PropTypes.Action)
    checklist: PropTypes.Checklist

  mixins: [
    Actor
    SortableList {
      connectWith: '.card-checklist-action-list'
      handle:      '.icon-handle'
      idAttribute: 'data-itemid'
      tolerance:   'intersect'
    }
  ]

  getInitialState: -> {
    ids: _.clone(@props.checklist.actions)
  }

  componentWillReceiveProps: (newProps) ->
    @setState {ids: newProps.checklist.actions}

  render: ->

    lookup = _.indexBy(@props.actions, 'id')
    items = _.map @state.ids, (id) =>
      action = lookup[id]
      return unless action?
      ListItem {key: action.id, 'data-itemid': action.id},
        CardAction {action}

    List {className: 'card-checklist-action-list'}, items

  getSortableList: ->
    @props.checklist

  getSortableListItem: (id) ->
    _.find @props.actions, (action) -> action.id == id

  onReorder: (action, toPosition) ->
    @publish new UserMovedActionEvent(action.id, @props.checklist.id, toPosition)

  onMove: (action, toChecklist, toPosition) ->
    @publish new UserMovedActionEvent(action.id, toChecklist.id, toPosition)

  onListOrderChanged: (ids) ->
    @setState {ids}

}

module.exports = CardChecklistActionList
