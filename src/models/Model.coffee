_ = require 'lodash'

class Model

  constructor: (data) ->
    _.extend(this, data)

module.exports = Model
