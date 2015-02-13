_         = require 'lodash'
React     = require 'react'
PropTypes = require 'framework/PropTypes'
Icon      = React.createFactory(require 'ui/common/Icon')
{div}     = React.DOM

FollowingHeader = React.createClass {

  displayName: 'FollowingHeader'

  render: ->

    div {className: 'header'},
      Icon {name: 'follow'}
      'Following'

}

module.exports = FollowingHeader
