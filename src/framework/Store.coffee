{EventEmitter} = require 'events'

class Store extends EventEmitter

  announce: ->
    console.log "announcing from #{@constructor.name}"
    @emit('change')

module.exports = Store
