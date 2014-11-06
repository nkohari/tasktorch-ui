_     = require 'lodash'
Store = require 'framework/Store'

class TypeStore extends Store

  constructor: ->
    @types = {}

  getType: (id) ->
    @types[id]

  onWorkspaceLoaded: (event) ->
    @types = _.indexBy(event.workspace.types, 'id')
    @announce()

  onTypesLoaded: (event) ->
    @types = _.extend @types, _.indexBy(event.types, 'id')
    @announce()

module.exports = TypeStore
