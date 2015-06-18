#--------------------------------------------------------------------------------
React  = require 'react'
Pure   = require 'ui/framework/mixins/Pure'
Button = React.createFactory(require 'ui/common/Button')
{div}  = React.DOM
#--------------------------------------------------------------------------------

FollowingFooter = React.createClass {

  displayName: 'FollowingFooter'

  mixins: [Pure]

  render: ->

    div {className: 'footer'}

}

module.exports = FollowingFooter
