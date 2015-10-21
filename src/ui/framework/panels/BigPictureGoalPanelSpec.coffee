ViewSpec  = require 'ui/framework/ViewSpec'
PanelSpec = require 'ui/framework/panels/PanelSpec'

class BigPictureGoalPanelSpec extends PanelSpec

  constructor: (id) ->
    super('bigpicture', 'goal', id)

  deserialize: (data) ->
    {@id} = data

  toQuery: ->
    "g.#{@id}"

  fromQuery: (str) ->
    [code, @id] = str.split('.')

ViewSpec.registerPanel('g', 'goal', BigPictureGoalPanelSpec)
module.exports = BigPictureGoalPanelSpec
