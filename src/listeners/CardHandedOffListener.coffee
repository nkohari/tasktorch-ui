Listener = require 'framework/Listener'
CardHandedOffEvent = require 'events/CardHandedOffEvent'

class CardHandedOffListener extends Listener

  listensFor: 'CardHandedOff'

  createEvent: (message) ->
    {card, oldStack, newStack} = message.payload
    meta = {user: message.user}
    new CardHandedOffEvent(card, oldStack, newStack, meta)

module.exports = CardHandedOffListener
