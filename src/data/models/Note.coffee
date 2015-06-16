moment = require 'moment'
Model  = require 'data/framework/Model'

class Note extends Model

  type: 'Note'

  getTimeDifference: (other) ->
    moment(@created).diff(moment(other.created))

module.exports = Note
