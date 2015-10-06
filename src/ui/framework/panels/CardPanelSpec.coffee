ViewSpec  = require 'ui/framework/ViewSpec'
PanelSpec = require 'ui/framework/panels/PanelSpec'

class CardPanelSpec extends PanelSpec

  constructor: (id) ->
    super('workspace', id)

  serialize: ->
    "c.#{@id}"

  deserialize: (str) ->
    [code, @id] = str.split('.')

ViewSpec.registerPanel('c', CardPanelSpec)
module.exports = CardPanelSpec
