_ = require 'lodash'

class Model

  constructor: (data) ->
    _.extend(this, data)

  equals: (other) ->
    (this is other) or (other? and @id == other.id and @version == other.version)

module.exports = Model
