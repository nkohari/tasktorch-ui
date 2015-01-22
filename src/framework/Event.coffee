_ = require 'lodash'

class Event

  constructor: (@meta = {}) ->
    @type = @constructor.name.replace(/Event$/, '')

  createModels: (type, documents) ->
    _.map documents, (doc) -> new type(doc)

module.exports = Event
