_         = require 'lodash'
React     = require 'react'
Router    = require 'react-router'
PropTypes = require 'framework/PropTypes'
Url       = require 'framework/Url'
Icon      = React.createFactory(require 'ui/common/Icon')
Link      = React.createFactory(require 'ui/common/Link')

FollowingCloseLink = React.createClass {

  displayName: 'FollowingCloseLink'

  mixins: [Router.State]

  render: ->

    url = new Url(this)
    url.hideFollowing()

    Link url.makeLinkProps(className: 'close'),
      Icon {name: 'close'}

}

module.exports = FollowingCloseLink
