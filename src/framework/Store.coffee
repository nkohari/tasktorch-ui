_              = require 'lodash'
{EventEmitter} = require 'events'

class Store extends EventEmitter

  constructor: ->
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
    @announce() if changed

  remove: (items...) ->
    changed = false
    for item in _.flatten(items)
      if @items[item.id]?
        delete @items[item.id]
        changed = true
    @announce() if changed

  announce: ->
    console.log "Announcing from #{@constructor.name}"
    @emit('change')
    return null

module.exports = Store
