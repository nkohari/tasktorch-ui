ViewSpec  = require 'ui/framework/ViewSpec'
PanelSpec = require 'ui/framework/panels/PanelSpec'

class StackPanelSpec extends PanelSpec

  constructor: (id) ->
    super('workspace', 'stack', id)

  deserialize: (data) ->
    {@id} = data
    
  toQuery: ->
    "s.#{@id}"

  fromQuery: (str) ->
    [code, @id] = str.split('.')

ViewSpec.registerPanel('s', 'stack', StackPanelSpec)
module.exports = StackPanelSpec
