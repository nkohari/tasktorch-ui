_     = require 'lodash'
Store = require 'framework/Store'

class TypeStore extends Store

  constructor: ->
    @types = {}

  getType: (id) ->
    @types[id]

  onTypesLoaded: (event) ->
    @types = _.extend @types, _.indexBy(event.types, 'id')
    @announce()

module.exports = TypeStore
