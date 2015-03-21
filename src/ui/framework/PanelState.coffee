class PanelState

  constructor: (@id) ->
    @type = @constructor.type

  equals: (other) ->
    other.type == @type and other.id == @id

module.exports = PanelState
