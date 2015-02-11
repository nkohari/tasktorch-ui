_                      = require 'lodash'
React                  = require 'react'
PropTypes              = require 'framework/PropTypes'
classSet               = require 'util/classSet'
CardListDisplayedEvent = require 'events/display/CardListDisplayedEvent'
StackType              = require 'framework/enums/StackType'
Observe                = require 'framework/mixins/Observe'
SortableList           = require 'framework/mixins/SortableList'
MoveCardRequest        = require 'requests/MoveCardRequest'
List                   = React.createFactory(require 'ui/common/List')
StackCardListItem      = React.createFactory(require 'ui/panels/stack/StackCardListItem')
{ul}                   = React.DOM

StackCardList = React.createClass {

  displayName: 'StackCardList'

  propTypes:
    stack: PropTypes.Stack
    ids:   PropTypes.idArray

  mixins: [
    Observe('cards', 'notes', 'users')
    SortableList {
      connectWith: '.cards'
      idAttribute: 'data-itemid'
    }
  ]

  getInitialState: ->
    {ids: @props.stack.cards, dragActive: false, dropAllowed: undefined}

  componentDidMount: ->
    @publish new CardListDisplayedEvent(@props.stack.id, @props.stack.cards)

  componentWillReceiveProps: (newProps) ->
    unless _.isEqual(@props.stack.cards, newProps.stack.cards)
      @publish new CardListDisplayedEvent(newProps.stack.id, newProps.stack.cards)
      @setState {ids: newProps.stack.cards}

  sync: (stores) ->
    cards = stores.cards.getMany(@state.ids) if @state?.ids?
    {cards}

  isReady: ->
    @state.cards?

  render: ->

    classes = ['cards']
    if @state.dragActive
      classes.push('dragging')
      classes.push("drop-#{if @state.dropAllowed then 'allowed' else 'disallowed'}")

    items = _.map @state.cards, (card) =>
      StackCardListItem {
        key:   "card-#{card.id}"
        stack: @props.stack
        card:  card
      }

    List {@isReady, className: classes.join(' ')}, items

  getSortableList: ->
    @props.stack

  getSortableListItem: (id) ->
    _.find @state.cards, (card) -> card.id == id

  onDragStarted: (dragContext) ->
    @setState {dragActive: true, dropAllowed: @isDropAllowed(dragContext.item, dragContext.list)}

  onDragStopped: (dragContext) ->
    @setState {dragActive: false, dropAllowed: undefined}

  onReorder: (card, toPosition) ->
    @execute new MoveCardRequest(card, @props.stack.id, toPosition)

  onMove: (card, toStack, toPosition) ->
    @execute new MoveCardRequest(card, toStack.id, toPosition)

  onListOrderChanged: (ids) ->
    @setState {ids}, => @forceSync()

  isDropAllowed: (card, fromStack) ->
    return true

}

module.exports = StackCardList
