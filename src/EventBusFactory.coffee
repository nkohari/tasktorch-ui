EventBus                 = require './EventBus'
CardBodyChangedListener  = require './listeners/CardBodyChangedListener'
CardTitleChangedListener = require './listeners/CardTitleChangedListener'

EventBusFactory = {}
EventBusFactory.create = ->

  new EventBus [
    new CardBodyChangedListener()
    new CardTitleChangedListener()
  ]

module.exports = EventBusFactory
