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

  key: (model) ->
    # By default, ModelStore just provides a map between the model's primary key (id)
    # and the model. Subclasses can override this to key on a custom property.
    model.id

  get: (key) ->
    model = @models[key]
    if model?
      return model
    else
      if @states[key] != ReadyState.Loading
        debug.log("#{@displayName}: Cache miss on #{key}")
        @states[key] = ReadyState.Loading
        @load(key)
      return undefined

  # TODO: This is inefficient; it'll make a separate call for each cache miss.
  # We should roll this up into a bulk-get request.
  getAll: (keys) ->
    _.compact _.map keys, (key) => @get(key)

  set: (key, model) ->
    if compare.values(model, @models[key])
      debug.log("#{@displayName}: Ignoring set() for %O", model)
    else
      @models[key] = model
      @states[key] = ReadyState.Loaded
      @announce()
    return

  add: (models...) ->
    changed = false
    for model in _.flatten(models)
      key = @key(model)
      if compare.values(model, @models[key])
        debug.log("#{@displayName}: Ignoring add() for %O", model)
      else
        @models[key] = model
        @states[key] = ReadyState.Loaded
        changed = true
    @announce() if changed
    return

  remove: (key) ->
    @models[key] = undefined
    @states[key] = undefined
    @announce()

  clear: ->
    @models = {}
    @states = {}
    @announce()

module.exports = ModelStore
