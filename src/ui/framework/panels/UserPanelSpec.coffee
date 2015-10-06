ViewSpec  = require 'ui/framework/ViewSpec'
PanelSpec = require 'ui/framework/panels/PanelSpec'

class UserPanelSpec extends PanelSpec

  constructor: (id) ->
    super('workspace', id)

  serialize: ->
    "u.#{@id}"

  deserialize: (str) ->
    [code, @id] = str.split('.')

ViewSpec.registerPanel('u', UserPanelSpec)
module.exports = UserPanelSpec
