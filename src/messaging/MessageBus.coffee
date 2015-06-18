Pusher  = require 'pusher-js'
Request = require 'data/framework/Request'

Pusher.XHR = ->
  xhr = new XMLHttpRequest()
  xhr.withCredentials = true
  return xhr

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
