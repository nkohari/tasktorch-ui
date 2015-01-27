_     = require 'lodash'
Store = require 'framework/Store'

class OrgStore extends Store

  onOrgsLoaded: (event) ->
    @add(event.orgs)
    
module.exports = OrgStore
