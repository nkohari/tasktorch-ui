Model = require 'data/framework/Model'

class Checklist extends Model

  type: 'Checklist'

  constructor: (data) ->
    super(data)

module.exports = Model
