_ = require 'lodash'

funcs = ['log', 'error', 'warn', 'group', 'groupEnd']

module.exports = _.object _.map funcs, (name) ->
  func = (args...) -> if false and TASKTORCH_FLAGS_DEBUG then console[name].apply(console, args)
  [name, func]
