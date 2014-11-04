BigPictureController = require './BigPictureController'
CardStore            = require './stores/CardStore'
TeamStore            = require './stores/TeamStore'
UserStore            = require './stores/UserStore'

BigPictureEnvironment = {}

BigPictureEnvironment.createController = ->

  stores =
    cards: new CardStore()
    teams: new TeamStore()
    users: new UserStore()

  return new BigPictureController(stores)

module.exports = BigPictureEnvironment
