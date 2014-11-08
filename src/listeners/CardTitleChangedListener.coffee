Listener = require 'framework/Listener'
CardTitleChangedEvent = require 'events/CardTitleChangedEvent'

class CardTitleChangedListener extends Listener

  listensFor: 'CardTitleChanged'

  createEvent: (message) ->
    {document, payload} = message
    meta = {user: message.user}
    new CardTitleChangedEvent(document.id, payload.title, document.version)

module.exports = CardTitleChangedListener
