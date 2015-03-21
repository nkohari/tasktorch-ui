_     = require 'lodash'
Model = require 'data/framework/Model'

exports.hashes = hashes = (a, b) ->

  return true  if a is b
  return false unless a? and b?

  for key, value of a
    if _.isArray(value)
      return false unless arrays(value, b[key])
    else
      return false unless values(value, b[key])

  for key, value of b
    return false unless a[key]?

  return true

exports.arrays = arrays = (a, b) ->

  return true  if a is b
  return false unless a? and b?
  return false if a.length != b.length

  for value, index in a
    return false unless values(value, b[index])

  return true

exports.values = values = (a, b) ->

  if a is b
    return true
  else if a?.equals? and b?.equals?
    return a.equals(b)
  else
    return false
