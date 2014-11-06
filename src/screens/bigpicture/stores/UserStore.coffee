_     = require 'lodash'
Store = require 'framework/Store'

class UserStore extends Store

  constructor: ->
    @users = {}

  getUser: (id) ->
    @users[id]

  onUsersLoaded: (event) ->
    @users = _.extend @users, _.indexBy(event.users, 'id')
    console.log(@users)
    @announce()

module.exports = UserStore
