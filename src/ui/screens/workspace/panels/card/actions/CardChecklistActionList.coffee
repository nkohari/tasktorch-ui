#--------------------------------------------------------------------------------
_                    = require 'lodash'
React                = require 'react'
SortableMixin        = require 'sortablejs/react-sortable-mixin'
classSet             = require 'common/util/classSet'
compare              = require 'common/util/compare'
PropTypes            = require 'ui/framework/PropTypes'
Actor                = require 'ui/framework/mixins/Actor'
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

  sortableOptions:
    group: 'actions'
    model: 'actions'

  mixins: [Actor, SortableMixin]

  getInitialState: ->
    {actions: _.clone(@props.actions), dirty: false}

  componentWillReceiveProps: (newProps) ->
    if not @state.dirty
      @setState {actions: newProps.actions}
    else if not compare.arrays(newProps.actions, @props.actions)
      @setState {actions: newProps.actions, dirty: false}

  render: ->

    items = _.map @state.actions, (action) =>
      CardAction {key: action.id, action}

    ul {className: 'card-checklist-action-list'}, items

  handleUpdate: (event) ->
    actionid = event.item.getAttribute('data-itemid')
    @setState {dirty: true}
    @publish new UserMovedActionEvent(actionid, @props.checklist.id, event.newIndex)

  handleAdd: (event) ->
    actionid = event.item.getAttribute('data-itemid')
    @setState {dirty: true}
    @publish new UserMovedActionEvent(actionid, @props.checklist.id, event.newIndex)

}

module.exports = CardChecklistActionList
