Pusher  = require 'pusher-js'
Request = require 'data/framework/Request'

class MessageBus

  constructor: ->
    @_pusher = new Pusher '9bc5b19ceaf8c59adcea',
      authEndpoint: Request.urlFor('/_wsauth')
      encrypted: true

  addChannel: (name, channel) ->
    @[name] = channel

  addChannels: (hash) ->
    @addChannel(name, channel) for name, channel of hash

  subscribe: (name) ->
    @_pusher.subscribe(name)
    
module.exports = MessageBus
