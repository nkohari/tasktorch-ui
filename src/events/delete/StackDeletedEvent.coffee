Event = require 'framework/Event'

class StackDeletedEvent extends Event

  constructor: (@stack) ->
    super()

module.exports = StackDeletedEvent
