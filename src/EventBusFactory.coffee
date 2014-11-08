EventBus                      = require './EventBus'
CardBodyChangedListener       = require './listeners/CardBodyChangedListener'
CardTitleChangedListener      = require './listeners/CardTitleChangedListener'
JoinedPresenceChannelListener = require './listeners/JoinedPresenceChannelListener'
UserConnectedListener         = require './listeners/UserConnectedListener'
UserDisconnectedListener      = require './listeners/UserDisconnectedListener'

EventBusFactory = {}

EventBusFactory.create = ->

  new EventBus [
    new CardBodyChangedListener()
    new CardTitleChangedListener()
    new JoinedPresenceChannelListener()
    new UserConnectedListener()
    new UserDisconnectedListener()
  ]

module.exports = EventBusFactory
