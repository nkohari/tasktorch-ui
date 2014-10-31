{EventEmitter} = require 'events'

class Store extends EventEmitter

  announce: ->
    @emit('change')

module.exports = Store
