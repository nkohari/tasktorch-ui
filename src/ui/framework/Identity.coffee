cookies = require 'cookies-js'

class Identity

  constructor: (params) ->
    @userid = cookies('tt-userid')
    @orgid  = params.orgid

module.exports = Identity
