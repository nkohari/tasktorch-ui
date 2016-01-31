_ = require 'lodash'

module.exports = arrayEnum = (values) ->
  _.fromPairs _.map values, (value) -> [value, value]
