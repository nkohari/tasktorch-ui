_     = require 'lodash'
Store = require 'framework/Store'

class KindStore extends Store

  onKindsLoaded: (event) ->
    @add(event.kinds)

module.exports = KindStore
