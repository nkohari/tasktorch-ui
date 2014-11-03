_ = require 'lodash'

class ShellUrl

  constructor: (routes, params, query) ->
    @organizationId = params.organizationId

  makeLinkProps: (route) ->
    params = {@organizationId}
    query = {}
    return {to: route, params, query}

module.exports = ShellUrl
