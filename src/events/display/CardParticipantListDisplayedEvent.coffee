Event = require 'framework/Event'

class CardParticipantListDisplayedEvent extends Event

  constructor: (@cardId, @userIds) ->
    super()

module.exports = CardParticipantListDisplayedEvent
