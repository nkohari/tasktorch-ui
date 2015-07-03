_ = require 'lodash'

funcs = ['log', 'error', 'warn', 'group', 'groupEnd']

module.exports = _.object _.map funcs, (name) ->
  func = (args...) -> if TASKTORCH_FLAGS_DEBUG and false then console[name].apply(console, args)
  [name, func]
