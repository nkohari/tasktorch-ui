_         = require 'lodash'
React     = require 'react'
PropTypes = require 'ui/framework/PropTypes'
Pure      = require 'ui/framework/mixins/Pure'
Icon      = React.createFactory(require 'ui/common/Icon')
{div}     = React.DOM

FollowingHeader = React.createClass {

  displayName: 'FollowingHeader'

  mixins: [Pure]

  render: ->

    div {className: 'header'},
      Icon {name: 'follow'}
      'Following'

}

module.exports = FollowingHeader
