_     = require 'lodash'
Store = require '../../framework/Store'

class TypeStore extends Store

  constructor: ->
    @types = {}

  onWorkspaceLoaded: (event) ->
    @types = _.indexBy(event.workspace.types, 'id')
    @announce()

module.exports = TypeStore
