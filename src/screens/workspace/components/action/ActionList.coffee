_                 = require 'lodash'
PropTypes         = require 'common/PropTypes'
React             = require 'react'
Observe           = require 'mixins/Observe'
SortableList      = require 'mixins/SortableList'
MoveActionRequest = require 'requests/MoveActionRequest'
Action            = React.createFactory(require './Action')
Icon              = React.createFactory(require 'common/Icon')
{ul, li}          = React.DOM

ActionList = React.createClass {

  displayName: 'ActionList'

  propTypes:
    card:  PropTypes.Card
    kind:  PropTypes.Kind
    stage: PropTypes.Stage
    ids:   PropTypes.idArray

  mixins: [
    Observe('actions')
    SortableList {
      connectWith: '.action-list'
      handle:      '.icon-handle'
      idAttribute: 'data-itemid'
      tolerance:   'intersect'
    }
  ]

  getInitialState: ->
    {ids: @props.ids}

  componentWillReceiveProps: (newProps) ->
    @setState {ids: newProps.ids}, => @forceSync()

  sync: (stores) ->
    actions = stores.actions.getMany(@state.ids) if @state?.ids?
    {actions}

  ready: ->
    {actions: @state.actions?}

  render: ->
    ul {className: 'action-list'}, @contents()

  children: ->
    _.map @state.actions, (action) =>
      li {key: "action-#{action.id}", 'data-itemid': action.id}, [
        Action {action}
      ]

  getSortableList: ->
    @props.stage

  getSortableListItem: (id) ->
    _.find @state.actions, (action) -> action.id == id

  onReorder: (action, toPosition) ->
    @execute new MoveActionRequest(action, @props.card.id, @props.stage.id, toPosition)

  onMove: (action, toStage, toPosition) ->
    @execute new MoveActionRequest(action, @props.card.id, toStage.id, toPosition)

  onListOrderChanged: (ids) ->
    @setState {ids}, => @forceSync()

}

module.exports = ActionList
