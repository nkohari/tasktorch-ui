PanelState = require 'ui/framework/PanelState'

class FollowingPanelState extends PanelState

  @type: 'f'

  constructor: ->
    super('following')

module.exports = FollowingPanelState
