#--------------------------------------------------------------------------------
_                  = require 'lodash'
React              = require 'react'
compare            = require 'common/util/compare'
PropTypes          = require 'ui/framework/PropTypes'
classSet           = require 'common/util/classSet'
StackType          = require 'data/enums/StackType'
Actor              = require 'ui/framework/mixins/Actor'
CachedState        = require 'ui/framework/mixins/CachedState'
SortableList       = require 'ui/framework/mixins/SortableList'
UserMovedCardEvent = require 'events/ui/UserMovedCardEvent'
StackCard          = React.createFactory(require 'ui/screens/workspace/panels/stack/StackCard')
{ul, li}           = React.DOM
#--------------------------------------------------------------------------------
require './StackCardList.styl'
#--------------------------------------------------------------------------------

StackCardList = React.createClass {

  displayName: 'StackCardList'

  propTypes:
    stack: PropTypes.Stack
    cards: PropTypes.arrayOf(PropTypes.Card)

  mixins: [
    Actor
    SortableList {idAttribute: 'data-itemid', connectWith: '.stack-card-list'}
  ]

  getInitialState: -> {
    ids: _.clone(@props.stack?.cards)
    dragActive: false
    dropAllowed: undefined
  }

  componentWillReceiveProps: (newProps) ->
    unless compare.hashes(@props, newProps)
      @setState {ids: _.clone(newProps.stack.cards)}

  render: ->

    lookup = _.indexBy(@props.cards, 'id')
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

    ul {className: classes}, items

  getSortableList: ->
    @props.stack

  getSortableListItem: (id) ->
    _.find @props.cards, (card) -> card.id == id

  onDragStarted: (dragContext) ->
    @setState {dragActive: true, dropAllowed: @isDropAllowed(dragContext.item, dragContext.list)}

  onDragStopped: (dragContext) ->
    @setState {dragActive: false, dropAllowed: undefined}

  onReorder: (card, position) ->
    @publish new UserMovedCardEvent(card.id, @props.stack.id, position)

  onReceiveListItem: (card, stack, position) ->
    @publish new UserMovedCardEvent(card.id, stack.id, position)

  onListOrderChanged: (ids) ->
    @setState {ids}

  isDropAllowed: (card, stack) ->
    true

}

module.exports = StackCardList
