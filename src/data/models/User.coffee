UserFlag = require 'data/enums/UserFlag'
Model    = require 'data/framework/Model'

class User extends Model

  type: 'User'

  canGiveTokens: ->
    _.includes(@flags, UserFlag.CanGiveTokens)

  hasCompletedWalkthrough: ->
    _.includes(@flags, UserFlag.HasCompletedWalkthrough)

module.exports = User
