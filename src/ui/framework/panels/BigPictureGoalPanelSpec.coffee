ViewSpec  = require 'ui/framework/ViewSpec'
PanelSpec = require 'ui/framework/panels/PanelSpec'

class BigPictureGoalPanelSpec extends PanelSpec

  constructor: (id) ->
    super('bigpicture', id)

  serialize: ->
    "g.#{@id}"

  deserialize: (str) ->
    [code, @id] = str.split('.')

ViewSpec.registerPanel('g', BigPictureGoalPanelSpec)
module.exports = BigPictureGoalPanelSpec
