Listener = require '../../framework/Listener'
CardTitleChangedEvent = require '../events/CardTitleChangedEvent'

class CardTitleChangedListener extends Listener

  createEvent: (message) ->
    {document, payload} = message
    new CardTitleChangedEvent(document.id, payload.title, document.version)

module.exports = CardTitleChangedListener
