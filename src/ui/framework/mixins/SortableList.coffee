_      = require 'lodash'
React  = require 'react'
jQuery = require 'jquery'

require('jquery-ui')

# TODO: This (shamefully) uses jQuery UI Sortable to handle sorting, which
# is a huge hack. I blame the HTML5 drag and drop spec, the authors of which
# should clearly face trial in the Hague for crimes against humanity itself.
# Eventually this should be replaced with a more modern solution.

DRAG_STATE_KEY = 'drag-state'

SortableList = (mixinConfig) -> {

  componentDidMount: ->
    @_jQuery().sortable _.extend({
      appendTo: 'body'
      distance: 5
      forceHelperSize: true
      forcePlaceholderSize: true
      helper: 'clone'
      placeholder: 'drag-placeholder'
      revert: 100
      tolerance: 'pointer'
      scroll: true
      zIndex: 99999
      activate: @_onSortableActivate
      deactivate: @_onSortableDeactivate
      over: @_onSortableDragOver
      change: @_onSortableChange
      start: @_onSortableStart
      stop: @_onSortableStop
      receive: @_onSortableReceive
    }, mixinConfig)

  componentWillUnmount: ->
    @_jQuery().sortable('destroy')

  _jQuery: ->
    jQuery(@getDOMNode())

  _getDragState: (context) ->
    context.item.data(DRAG_STATE_KEY)

  _setDragState: (context, patch) ->
    newState = _.extend({}, @_getDragState(context), patch)
    context.item.data(DRAG_STATE_KEY, newState)

  _onSortableActivate: (event, context) ->
    @onDragStarted(@_getDragState(context)) if @onDragStarted?

  _onSortableDeactivate: (event, context) ->
    @onDragStopped(@_getDragState(context)) if @onDragStopped?

  _onSortableDragOver: (event, context) ->
    @_setDragState context, {
      toList: @getSortableList()
      toPosition: @_getCurrentPosition(context)
    }

  _onSortableStart: (event, context) ->
    context.placeholder.css {
      width:  context.helper.outerWidth()
      height: context.helper.outerHeight()
    }
    item = @getSortableListItem(context.item.attr(mixinConfig.idAttribute))
    list = @getSortableList()
    position = context.item.index()
    @_setDragState context, {
      item:         item
      fromList:     list
      fromPosition: position
      toList:       list
      toPosition:   position
    }

  _onSortableStop: (event, context) ->
    dragState = @_getDragState(context)
    ids = @_getCurrentOrder()
    @_jQuery().sortable('cancel')
    if not context.sender? and dragState.fromList.id == dragState.toList.id and dragState.fromPosition != dragState.toPosition
      @onReorder(dragState.item, dragState.toPosition) if @onReorder?
    @onListOrderChanged(ids) if @onListOrderChanged?

  _onSortableChange: (event, context) ->
    @_setDragState context, {
      toPosition: @_getCurrentPosition(context)
    }

  _onSortableReceive: (event, context) ->
    dragState = context.item.data(DRAG_STATE_KEY)
    ids = @_getCurrentOrder()
    @onMove(dragState.item, dragState.toList, dragState.toPosition) if @onMove?
    @onListOrderChanged(ids) if @onListOrderChanged?

  _getCurrentOrder: ->
    @_jQuery().sortable('toArray', {attribute: mixinConfig.idAttribute})

  _getCurrentPosition: (context) ->
    dragState = @_getDragState(context)
    position = context.placeholder.index()
    if dragState.fromList == dragState.toList and position > context.item.index()
      return position - 1
    else
      return position

}

module.exports = SortableList
