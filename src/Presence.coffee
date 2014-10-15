_ = require 'lodash'

class Presence

  constructor: ->
    @pusher = new Pusher '9bc5b19ceaf8c59adcea',
      authEndpoint: '/api/_auth/presence'
      encrypted: true
    @pusher.log = (msg) -> console.log(msg)

  subscribe: (organizationId) ->
    @pusher.unsubscribe() if @channel?
    @channel = @pusher.subscribe("presence-#{organizationId}")

  unsubscribe: ->
    @pusher.unsubscribe()
    @channel = undefined

  getConnectedUsers: ->
    _.pluck(@channel.members, 'info')

global.Presence = module.exports = new Presence()
