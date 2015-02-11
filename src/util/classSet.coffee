_ = require 'lodash'

module.exports = classSet = (hash) ->
  classes = _.flatten _.map hash, (value, className) ->
    if value then className else null
  return classes.join(' ')
