class PanelSpec

  @fromQuery: (str) ->
    panel = new this()
    panel.fromQuery(str)
    return panel

  @deserialize: (data) ->
    panel = new this()
    panel.deserialize(data)
    return panel

  constructor: (@screen, @type, @id) ->

  toQuery: ->
    throw new Error("You must implement toQuery() on #{@constructor.name}")

  fromQuery: (tokens) ->
    throw new Error("You must implement fromQuery() on #{@constructor.name}")

module.exports = PanelSpec