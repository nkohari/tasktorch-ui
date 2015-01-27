_ = require 'lodash'

class BigPictureUrl

  constructor: (routes, params, query) ->
    @orgId = params.orgId
    @users = if query.users? then query.users.split(',') else []

  setUsers: (userIds) ->
    @users = _.clone(userIds)

  makeLinkProps: ->
    params = {@orgId}
    query  = {}
    query.users = @users.join(',') if @users.length > 0
    return {to: 'bigpicture', params, query}

module.exports = BigPictureUrl
