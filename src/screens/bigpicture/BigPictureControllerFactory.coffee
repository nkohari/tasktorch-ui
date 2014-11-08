BigPictureController = require './BigPictureController'
CardStore            = require './stores/CardStore'
TeamStore            = require './stores/TeamStore'
UserStore            = require './stores/UserStore'

BigPictureEnvironment = {}

BigPictureEnvironment.createController = (organizationId, eventBus) ->

  new BigPictureController(organizationId, eventBus, {
    cards: new CardStore()
    teams: new TeamStore()
    users: new UserStore()
  })

module.exports = BigPictureEnvironment
