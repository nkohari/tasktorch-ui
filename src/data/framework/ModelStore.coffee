_          = require 'lodash'
compare    = require 'common/util/compare'
Store      = require 'data/framework/Store'
Model      = require 'data/framework/Model'
ReadyState = require 'data/enums/ReadyState'

class ModelStore extends Store

  constructor: (eventQueue, processor, cache) ->
    super(eventQueue, processor, cache)
    @models = {}
    @states = {}

  get: (id) ->
    model = @models[id]
    if model?
      return model
    else
      if @states[id] != ReadyState.Loading
        debug.log("#{@displayName}: Cache miss on #{id}")
        @states[id] = ReadyState.Loading
        @load(id)
      return undefined

  # TODO: This is inefficient; it'll make a separate call for each cache miss.
  # We should roll this up into a bulk-get request.
  getAll: (ids) ->
    _.compact _.map ids, (id) => @get(id)

  set: (id, model) ->
    if compare.values(model, @models[id])
      debug.log("#{@displayName}: Ignoring set() for %O", model)
    else
      @models[id] = model
      @states[id] = ReadyState.Loaded
      @announce()
    return

  add: (models...) ->
    changed = false
    for model in _.flatten(models)
      id = model.id
      if compare.values(model, @models[id])
        debug.log("#{@displayName}: Ignoring add() for %O", model)
      else
        @models[id] = model
        @states[id] = ReadyState.Loaded
        changed = true
    @announce() if changed
    return

  remove: (id) ->
    @models[id] = undefined
    @states[id] = undefined
    @announce()

  clear: ->
    @models = {}
    @states = {}
    @announce()

module.exports = ModelStore
