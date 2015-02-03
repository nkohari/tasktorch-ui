_ = require 'lodash'

class Event

  constructor: (@meta = {}) ->

  createModels: (type, documents) ->
    _.map documents, (doc) -> new type(doc)

module.exports = Event
