ViewSpec  = require 'ui/framework/ViewSpec'
PanelSpec = require 'ui/framework/panels/PanelSpec'

class BigPictureKindPanelSpec extends PanelSpec

  constructor: (id) ->
    super('bigpicture', id)

  serialize: ->
    "k.#{@id}"

  deserialize: (str) ->
    [code, @id] = str.split('.')
    
ViewSpec.registerPanel('k', BigPictureKindPanelSpec)
module.exports = BigPictureKindPanelSpec
