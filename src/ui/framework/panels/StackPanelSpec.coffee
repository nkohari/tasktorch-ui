ViewSpec  = require 'ui/framework/ViewSpec'
PanelSpec = require 'ui/framework/panels/PanelSpec'

class StackPanelSpec extends PanelSpec

  constructor: (id) ->
    super('workspace', id)

  serialize: ->
    "s.#{@id}"

  deserialize: (str) ->
    [code, @id] = str.split('.')

ViewSpec.registerPanel('s', StackPanelSpec)
module.exports = StackPanelSpec
