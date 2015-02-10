_ = require 'lodash'

class ShellUrl

  constructor: (component) ->
    params = component.getParams()
    @orgid = params.orgid

  makeLinkProps: (route) ->
    params = {@orgid}
    query  = {}
    return {to: route, params, query}

module.exports = ShellUrl
