_ = require 'lodash'

class BigPictureUrl

  constructor: (routes, params, query) ->
    @organizationId = params.organizationId
    @users = if query.users? then query.users.split(',') else []

  setUsers: (userIds) ->
    @users = _.clone(userIds)

  makeLinkProps: ->
    params = {@organizationId}
    query  = {}
    query.users = @users.join(',') if @users.length > 0
    return {to: 'bigpicture', params, query}

module.exports = BigPictureUrl
