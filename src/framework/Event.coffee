class Event

  constructor: (@meta = {}) ->
    @type = @constructor.name.replace(/Event$/, '')
    console.log(this)

module.exports = Event
