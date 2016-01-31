_ = require 'lodash'

funcs = ['log', 'error', 'warn', 'group', 'groupEnd']

module.exports = _.fromPairs _.map funcs, (name) ->
  func = (args...) -> if TASKTORCH_FLAGS_DEBUG then console[name].apply(console, args)
  [name, func]
