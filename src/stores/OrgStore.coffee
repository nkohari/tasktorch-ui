_     = require 'lodash'
Store = require 'framework/Store'

class OrgStore extends Store

  displayName: 'OrgStore'

  onOrgsLoaded: (event) ->
    @add(event.orgs)
    
module.exports = OrgStore
