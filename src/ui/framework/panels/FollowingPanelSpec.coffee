ViewSpec  = require 'ui/framework/ViewSpec'
PanelSpec = require 'ui/framework/panels/PanelSpec'

class FollowingPanelSpec extends PanelSpec

  constructor: ->
    super('workspace', 'following', 'following')
    
  deserialize: (data) ->
    # Nothing to deserialize
    
  toQuery: ->
    'f'

  fromQuery: (str) ->
    # Nothing to deserialize

ViewSpec.registerPanel('f', 'following', FollowingPanelSpec)
module.exports = FollowingPanelSpec
