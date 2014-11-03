_ = require 'lodash'

class NavigationUrl

  constructor: (routes, params, query) ->
    @organizationId = params.organizationId

  makeLinkProps: (route) ->
    params = {@organizationId}
    query = {}
    return {to: route, params, query}

module.exports = NavigationUrl
