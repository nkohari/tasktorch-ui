ViewSpec  = require 'ui/framework/ViewSpec'
PanelSpec = require 'ui/framework/panels/PanelSpec'

class BigPictureTeamPanelSpec extends PanelSpec

  constructor: (id) ->
    super('bigpicture', id)

  serialize: ->
    "t.#{@id}"

  deserialize: (str) ->
    [code, @id] = str.split('.')

ViewSpec.registerPanel('t', BigPictureTeamPanelSpec)
module.exports = BigPictureTeamPanelSpec
