class Event

  constructor: (@meta = {}) ->
    @type = @constructor.name.replace(/Event$/, '')

module.exports = Event
