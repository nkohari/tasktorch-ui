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
StackCardListItem  = React.createFactory(require 'ui/screens/workspace/panels/stack/StackCardListItem')
{ul}               = React.DOM

StackCardList = React.createClass {

  displayName: 'StackCardList'

  propTypes:
    stack: PropTypes.Stack
    ids:   PropTypes.idArray

  mixins: [
    Actor
    CachedState
    SortableList {
      connectWith: '.cards'
      idAttribute: 'data-itemid'
    }
  ]

  getInitialState: ->
    {dragActive: false, dropAllowed: undefined}

  getCachedState: (cache) -> {
    cards: cache('cardsByStack').get(@props.stack.id)
  }

  isReady: ->
    @state.cards?

  render: ->

    items = _.map @state.cards, (card) =>
      StackCardListItem {
        key:   "card-#{card.id}"
        stack: @props.stack
        card:  card
      }

    classes = classSet [
      'cards'
      'dragging'        if @state.dragActive
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
    @publish new UserMovedCardEvent(card.id, @props.stack.id, toPosition)

  onMove: (card, toStack, toPosition) ->
    @publish new UserMovedCardEvent(card.id, toStack.id, toPosition)

  onListOrderChanged: (ids) ->

  isDropAllowed: (card, fromStack) ->
    return true

}

module.exports = StackCardList
