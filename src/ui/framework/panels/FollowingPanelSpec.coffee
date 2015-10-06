ViewSpec  = require 'ui/framework/ViewSpec'
PanelSpec = require 'ui/framework/panels/PanelSpec'

class FollowingPanelSpec extends PanelSpec

  constructor: ->
    super('workspace', 'following')
    
  serialize: ->
    'f'

  deserialize: (str) ->
    # Nothing to deserialize

ViewSpec.registerPanel('f', FollowingPanelSpec)
module.exports = FollowingPanelSpec
