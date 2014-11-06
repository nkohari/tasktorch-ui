{EventEmitter} = require 'events'

class Store extends EventEmitter

  announce: ->
    @emit('change')
    return null

module.exports = Store
