Listener = require '../../framework/Listener'
CardBodyChangedEvent = require '../events/CardBodyChangedEvent'

class CardBodyChangedListener extends Listener

  createEvent: (message) ->
    {document, payload} = message
    new CardBodyChangedEvent(document.id, payload.body, document.version)

module.exports = CardBodyChangedListener
