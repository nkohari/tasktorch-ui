Event = require 'framework/Event'

class StackDeletedEvent extends Event

  type: 'StackDeleted'

  constructor: (@stack) ->
    super()

module.exports = StackDeletedEvent
