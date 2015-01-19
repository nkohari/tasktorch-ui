_              = require 'lodash'
{EventEmitter} = require 'events'

class Store extends EventEmitter

  constructor: ->
    @setMaxListeners(100)
    @items = {}

  get: (id) ->
    @items[id] ? undefined

  getMany: (ids...) ->
    items = []
    for id in _.flatten(ids)
      item = @items[id]
      return undefined unless item?
      items.push(item)
    return items

  getAll: ->
    _.values(@items)

  add: (items...) ->
    changed = false
    for item in _.flatten(items)
      existing = @items[item.id]
      if not existing? or item.version > existing.version
        @items[item.id] = item
        changed = true
    if changed
      @announce()
    else
      console.debug("#{@constructor.name}: ignoring add()")

  remove: (items...) ->
    changed = false
    for item in _.flatten(items)
      if @items[item.id]?
        delete @items[item.id]
        changed = true
    if changed
      @announce()
    else
      console.debug("#{@constructor.name}: ignoring remove()")

  execute: (request) ->
    console.debug("#{@constructor.name}: executing %O", request)
    request.execute(AppContext, EventBus)

  announce: ->
    console.debug("#{@constructor.name}: announcing changes")
    @emit('change')
    return null

module.exports = Store
