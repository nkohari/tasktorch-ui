_                      = require 'lodash'
React                  = require 'react'
PropTypes              = require 'common/PropTypes'
CardListDisplayedEvent = require 'events/display/CardListDisplayedEvent'
StackType              = require 'framework/enums/StackType'
Observe                = require 'mixins/Observe'
QueueCard              = React.createFactory(require './cards/QueueCard')
InboxCard              = React.createFactory(require './cards/InboxCard')
DraftsCard             = React.createFactory(require './cards/DraftsCard')
BacklogCard            = React.createFactory(require './cards/BacklogCard')
{ul}                   = React.DOM

StackCardList = React.createClass {

  displayName: 'StackCardList'

  propTypes:
    stack: PropTypes.Stack

  mixins: [Observe('cards')]

  componentWillMount: ->
    @publish new CardListDisplayedEvent(@props.stack.id, @props.stack.cards)

  componentWillReceiveProps: (newProps) ->
    unless _.isEqual(@props.stack.cards, newProps.stack.cards)
      @publish new CardListDisplayedEvent(newProps.stack.id, newProps.stack.cards)

  sync: (stores) ->
    {cards: stores.cards.getMany(@props.stack.cards)}

  ready: ->
    {cards: @state.cards?}

  render: ->
    ul {className: 'cards'}, @renderChildrenIfReady()

  children: ->
    _.map @state.cards, @renderCard

  renderCard: (card) ->
    props = {key: "card-#{card.id}", stack: @props.stack, card}
    switch @props.stack.type
      when StackType.Queue   then QueueCard(props)   
      when StackType.Inbox   then InboxCard(props)
      when StackType.Drafts  then DraftsCard(props)
      when StackType.Backlog then BacklogCard(props)

}

module.exports = StackCardList
