moment = require 'moment'
Model  = require './Model'

class Note extends Model

  getTimeDifference: (other) ->
    moment(@time).diff(moment(other.time))

module.exports = Note
