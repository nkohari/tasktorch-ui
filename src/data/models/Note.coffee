moment = require 'moment'
Model  = require 'data/framework/Model'

class Note extends Model

  type: 'Note'

  getTimeDifference: (other) ->
    moment(@time).diff(moment(other.time))

module.exports = Note
