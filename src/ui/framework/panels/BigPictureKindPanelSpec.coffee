ViewSpec  = require 'ui/framework/ViewSpec'
PanelSpec = require 'ui/framework/panels/PanelSpec'

class BigPictureKindPanelSpec extends PanelSpec

  constructor: (id) ->
    super('bigpicture', 'kind', id)

  deserialize: (data) ->
    {@id} = data
    
  toQuery: ->
    "k.#{@id}"

  fromQuery: (str) ->
    [code, @id] = str.split('.')
    
ViewSpec.registerPanel('k', 'kind', BigPictureKindPanelSpec)
module.exports = BigPictureKindPanelSpec
