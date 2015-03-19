_          = require 'lodash'
compare    = require 'common/util/compare'
Store      = require 'data/framework/Store'
Model      = require 'data/framework/Model'
ReadyState = require 'data/enums/ReadyState'

class ModelStore extends Store

  constructor: (eventQueue, cache) ->
    super(eventQueue, cache)
    @models = {}
    @states = {}

  get: (id) ->
    model = @models[id]
    if model?
      return model
    else
      if @states[id] != ReadyState.Loading
        console.debug("#{@displayName}: Cache miss on #{id}")
        @states[id] = ReadyState.Loading
        @load(id)
      return undefined

  set: (id, model) ->
    if compare.values(model, @models[id])
      console.debug("#{@displayName}: Ignoring set() for %O", model)
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
        console.debug("#{@displayName}: Ignoring add() for %O", model)
      else
        @models[id] = model
        @states[id] = ReadyState.Loaded
        changed = true
    @announce() if changed
    return

module.exports = ModelStore