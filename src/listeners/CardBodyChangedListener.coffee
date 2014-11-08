Listener = require 'framework/Listener'
CardBodyChangedEvent = require 'events/CardBodyChangedEvent'

class CardBodyChangedListener extends Listener

  listensFor: 'CardBodyChanged'

  createEvent: (message) ->
    {document, payload} = message
    meta = {user: message.user}
    new CardBodyChangedEvent(document.id, payload.body, document.version, meta)

module.exports = CardBodyChangedListener
