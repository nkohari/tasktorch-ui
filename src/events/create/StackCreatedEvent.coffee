Event = require 'framework/Event'

class StackCreatedEvent extends Event

  type: 'StackCreated'

  constructor: (@stack) ->
    super()

module.exports = StackCreatedEvent
