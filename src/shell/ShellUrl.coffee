_ = require 'lodash'

class ShellUrl

  constructor: (routes, params, query) ->
    @orgId = params.orgId

  makeLinkProps: (route) ->
    params = {@orgId}
    query  = {}
    return {to: route, params, query}

module.exports = ShellUrl
