UserFlag = require 'data/enums/UserFlag'
Model    = require 'data/framework/Model'

class User extends Model

  type: 'User'

  canGiveTokens: ->
    _.contains(@flags, UserFlag.CanGiveTokens)

  hasCompletedWalkthrough: ->
    _.contains(@flags, UserFlag.HasCompletedWalkthrough)

module.exports = User
