{EventEmitter} = require 'events'

class Store extends EventEmitter

  announce: ->
    console.log "Announcing from #{@constructor.name}"
    @emit('change')
    return null

module.exports = Store
