_ = require 'lodash'

class BigPictureUrl

  constructor: (routes, params, query) ->
    @orgid = params.orgid
    @users = if query.users? then query.users.split(',') else []

  setUsers: (userids) ->
    @users = _.clone(userids)

  makeLinkProps: ->
    params = {@orgid}
    query  = {}
    query.users = @users.join(',') if @users.length > 0
    return {to: 'bigpicture', params, query}

module.exports = BigPictureUrl
