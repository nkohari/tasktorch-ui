_ = require 'lodash'

class ShellUrl

  constructor: (routes, params, query) ->
    @orgid = params.orgid

  makeLinkProps: (route) ->
    params = {@orgid}
    query  = {}
    return {to: route, params, query}

module.exports = ShellUrl
