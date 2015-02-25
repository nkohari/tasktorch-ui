_         = require 'lodash'
React     = require 'react'
PanelKey  = require 'ui/framework/PanelKey'
PropTypes = require 'ui/framework/PropTypes'
Icon      = React.createFactory(require 'ui/common/Icon')
Link      = React.createFactory(require 'ui/common/Link')

FollowingCloseLink = React.createClass {

  displayName: 'FollowingCloseLink'

  render: ->
    Link {className: 'close', @getLinkUrl},
      Icon {name: 'close'}

  getLinkUrl: (currentUrl) ->
    currentUrl.removePanel(PanelKey.forFollowing())

}

module.exports = FollowingCloseLink
