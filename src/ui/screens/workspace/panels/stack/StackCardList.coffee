#--------------------------------------------------------------------------------
_                  = require 'lodash'
React              = require 'react'
PropTypes          = require 'ui/framework/PropTypes'
classSet           = require 'common/util/classSet'
StackType          = require 'data/enums/StackType'
Actor              = require 'ui/framework/mixins/Actor'
CachedState        = require 'ui/framework/mixins/CachedState'
SortableList       = require 'ui/framework/mixins/SortableList'
UserMovedCardEvent = require 'events/ui/UserMovedCardEvent'
List               = React.createFactory(require 'ui/common/List')
StackCard          = React.createFactory(require 'ui/screens/workspace/panels/stack/StackCard')
{ul, li}           = React.DOM
#--------------------------------------------------------------------------------
require './StackCardList.styl'
#--------------------------------------------------------------------------------

StackCardList = React.createClass {

  displayName: 'StackCardList'

  propTypes:
    stack: PropTypes.Stack
    ids:   PropTypes.idArray

  mixins: [
    Actor
    CachedState
    SortableList {
      connectWith: '.stack-card-list'
      idAttribute: 'data-itemid'
    }
  ]

  getInitialState: -> {
    ids: _.clone(@props.stack.cards)
    dragActive: false
    dropAllowed: undefined
  }

  getCachedState: (cache) -> {
    cards: cache('cardsByStack').get(@props.stack.id)
  }

  isReady: ->
    @state.cards?

  componentWillReceiveProps: (newProps) ->
    console.log 'componentWillReceiveProps()'
    @setState {ids: _.clone(newProps.stack.cards)}

  render: ->

    lookup = _.indexBy(@state.cards, 'id')
    items = _.map @state.ids, (id) =>
      card = lookup[id]
      return unless card?
      StackCard {key: card.id, stack: @props.stack, card}

    classes = classSet [
      'stack-card-list'
      'drag-active'     if @state.dragActive
      'drop-allowed'    if @state.dragActive and @state.dropAllowed
      'drop-disallowed' if @state.dragActive and not @state.dropAllowed
    ]

    List {@isReady, className: classes}, items

  getSortableList: ->
    @props.stack

  getSortableListItem: (id) ->
    _.find @state.cards, (card) -> card.id == id

  onDragStarted: (dragContext) ->
    @setState {dragActive: true, dropAllowed: @isDropAllowed(dragContext.item, dragContext.list)}

  onDragStopped: (dragContext) ->
    @setState {dragActive: false, dropAllowed: undefined}

  onReorder: (card, toPosition) ->
    console.log 'onReorder()'
    @publish new UserMovedCardEvent(card.id, @props.stack.id, toPosition)

  onMove: (card, toStack, toPosition) ->
    console.log 'onMove()'
    @publish new UserMovedCardEvent(card.id, toStack.id, toPosition)

  onListOrderChanged: (ids) ->
    console.log "onListOrderChanged(): #{ids.join(',')}"
    @setStateAndSync {ids}

  isDropAllowed: (card, stack) ->
    true

}

module.exports = StackCardList
