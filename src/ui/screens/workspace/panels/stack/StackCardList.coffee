#--------------------------------------------------------------------------------
_                  = require 'lodash'
React              = require 'react'
SortableMixin      = require 'sortablejs/react-sortable-mixin'
compare            = require 'common/util/compare'
PropTypes          = require 'ui/framework/PropTypes'
classSet           = require 'common/util/classSet'
StackType          = require 'data/enums/StackType'
Actor              = require 'ui/framework/mixins/Actor'
CachedState        = require 'ui/framework/mixins/CachedState'
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

  mixins: [Actor, SortableMixin]

  sortableOptions:
    group: 'cards'
    model: 'cards'

  getInitialState: ->
    {cards: _.clone(@props.cards)}

  componentWillReceiveProps: (newProps) ->
    if not compare.values(@props.stack, newProps.stack)
      @setState {cards: newProps.cards}

  render: ->

    items = _.map _.compact(@state.cards), (card) =>
      StackCard {key: card.id, stack: @props.stack, card}

    ul {className: 'stack-card-list'}, items

  handleUpdate: (event) ->
    cardid = event.item.getAttribute('data-id')
    @publish new UserMovedCardEvent(cardid, @props.stack.id, event.newIndex)

  handleAdd: (event) ->
    cardid = event.item.getAttribute('data-id')
    @publish new UserMovedCardEvent(cardid, @props.stack.id, event.newIndex)

}

module.exports = StackCardList
