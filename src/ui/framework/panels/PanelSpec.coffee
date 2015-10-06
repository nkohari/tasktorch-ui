class PanelSpec

  @fromTokens: (str) ->
    panel = new this()
    panel.deserialize(str)
    return panel

  constructor: (@screen, @id) ->

  serialize: ->
    throw new Error("You must implement serialize() on #{@constructor.name}")

  deserialize: (tokens) ->
    throw new Error("You must implement deserialize() on #{@constructor.name}")

module.exports = PanelSpec