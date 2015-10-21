ViewSpec  = require 'ui/framework/ViewSpec'
PanelSpec = require 'ui/framework/panels/PanelSpec'

class UserPanelSpec extends PanelSpec

  constructor: (id) ->
    super('workspace', 'user', id)

  deserialize: (data) ->
    {@id} = data
    
  toQuery: ->
    "u.#{@id}"

  fromQuery: (str) ->
    [code, @id] = str.split('.')

ViewSpec.registerPanel('u', 'user', UserPanelSpec)
module.exports = UserPanelSpec
