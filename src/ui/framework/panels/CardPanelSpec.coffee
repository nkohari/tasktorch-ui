ViewSpec  = require 'ui/framework/ViewSpec'
PanelSpec = require 'ui/framework/panels/PanelSpec'

class CardPanelSpec extends PanelSpec

  constructor: (id) ->
    super('workspace', 'card', id)

  deserialize: (data) ->
    {@id} = data
    
  toQuery: ->
    "c.#{@id}"

  fromQuery: (str) ->
    [code, @id] = str.split('.')

ViewSpec.registerPanel('c', 'card', CardPanelSpec)
module.exports = CardPanelSpec
