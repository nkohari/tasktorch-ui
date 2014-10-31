class Event

  constructor: ->
    @type = @constructor.name.replace(/Event$/, '')
    console.log(this)

module.exports = Event
