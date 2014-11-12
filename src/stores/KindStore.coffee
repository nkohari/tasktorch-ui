_     = require 'lodash'
Store = require 'framework/Store'

class KindStore extends Store

  constructor: ->
    @kinds = {}

  getKind: (id) ->
    @kinds[id]

  onKindsLoaded: (event) ->
    @kinds = _.extend @kinds, _.indexBy(event.kinds, 'id')
    @announce()

module.exports = KindStore
