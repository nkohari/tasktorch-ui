_                    = require 'lodash'
PropTypes            = require 'ui/framework/PropTypes'
React                = require 'react'
Actor                = require 'ui/framework/mixins/Actor'
SortableList         = require 'ui/framework/mixins/SortableList'
UserMovedActionEvent = require 'events/ui/UserMovedActionEvent'
List                 = React.createFactory(require 'ui/common/List')
ListItem             = React.createFactory(require 'ui/common/ListItem')
Icon                 = React.createFactory(require 'ui/common/Icon')
Action               = React.createFactory(require 'ui/panels/card/actions/Action')

ActionList = React.createClass {

  displayName: 'ActionList'

  propTypes:
    actions: PropTypes.arrayOf(PropTypes.Action)
    card:    PropTypes.Card
    kind:    PropTypes.Kind
    stage:   PropTypes.Stage
    ids:     PropTypes.idArray

  mixins: [
    Actor
    SortableList {
      connectWith: '.action-list'
      handle:      '.icon-handle'
      idAttribute: 'data-itemid'
      tolerance:   'intersect'
    }
  ]

  getInitialState: ->
    {ids: @props.ids}

  render: ->

    items = _.map @props.actions, (action) =>
      ListItem {key: "action-#{action.id}", className: 'action-list-item', 'data-itemid': action.id},
        Action {action}

    List {className: 'action-list'}, items

  getSortableList: ->
    @props.stage

  getSortableListItem: (id) ->
    _.find @props.actions, (action) -> action.id == id

  onReorder: (action, toPosition) ->
    @publish new UserMovedActionEvent(action.id, @props.card.id, @props.stage.id, toPosition)

  onMove: (action, toStage, toPosition) ->
    @publish new UserMovedActionEvent(action.id, @props.card.id, toStage.id, toPosition)

  onListOrderChanged: (ids) ->

}

module.exports = ActionList
