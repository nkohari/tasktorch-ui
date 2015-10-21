ViewSpec  = require 'ui/framework/ViewSpec'
PanelSpec = require 'ui/framework/panels/PanelSpec'

class BigPictureTeamPanelSpec extends PanelSpec

  constructor: (id) ->
    super('bigpicture', 'team', id)

  deserialize: (data) ->
    {@id} = data
    
  toQuery: ->
    "t.#{@id}"

  fromQuery: (str) ->
    [code, @id] = str.split('.')

ViewSpec.registerPanel('t', 'team', BigPictureTeamPanelSpec)
module.exports = BigPictureTeamPanelSpec
