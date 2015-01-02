_                = require 'lodash'
React            = require 'react/addons'
Observe          = require 'mixins/Observe'
SortableList     = require 'mixins/SortableList'
CardAction       = React.createFactory(require './CardAction')
{a, div, ul, li} = React.DOM
{classSet}       = React.addons

CardActionList = React.createClass {

  displayName: 'CardActionList'

  mixins: [
    Observe('actions')
    SortableList {
      connectWith: '.action-list'
      handle:      '.handle'
      idAttribute: 'data-itemid'
      tolerance:   'intersect'
    }
  ]

  getInitialState: ->
    {ids: @props.ids}

  componentWillReceiveProps: (newProps) ->
    @setState {ids: newProps.ids}

  sync: (stores) ->
    console.log "SYNC ACTIONS FOR STAGE #{@props.stage.id}: #{@state?.ids?.join(',')}"
    actions = stores.actions.getMany(@state.ids) if @state?.ids?
    {actions}

  ready: ->
    {actions: @state.actions?}

  render: ->
    ul {className: 'action-list'}, @contents()

  children: ->
    _.map @state.actions, (action) =>
      CardAction {key: "action-#{action.id}", action}

  getSortableList: ->
    @props.stage

  getSortableListItem: (id) ->
    _.find @state.actions, (action) -> action.id == id

  onReorder: (action, toPosition) ->
    console.log "REORDER (#{@props.stage.id}): action #{action.id} moved to position #{toPosition}"

  onMove: (action, toStage, toPosition) ->
    console.log "MOVE (#{@props.stage.id}): action #{action.id} to stage #{toStage.id} at position #{toPosition}"

  onListOrderChanged: (ids) ->
    @setState {ids}, => @forceSync()

}

module.exports = CardActionList
