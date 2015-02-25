Model = require 'data/framework/Model'

class Card extends Model

  type: 'Card'

  constructor: (data) ->
    super(data)

module.exports = Model
