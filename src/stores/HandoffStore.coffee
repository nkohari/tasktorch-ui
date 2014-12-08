_     = require 'lodash'
Store = require 'framework/Store'

class HandoffStore extends Store

  constructor: ->
    @handoffs = {}

  getHandoff: (id) ->
    @handoffs[id]

  onHandoffsLoaded: (event) ->
    @handoffs = _.extend @handoffs, _.indexBy(event.handoffs, 'id')
    @announce()

module.exports = HandoffStore
