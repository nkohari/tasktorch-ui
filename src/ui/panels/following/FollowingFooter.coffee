React  = require 'react'
Button = React.createFactory(require 'ui/common/Button')
{div}  = React.DOM

FollowingFooter = React.createClass {

  displayName: 'FollowingFooter'

  render: ->

    div {className: 'footer'}

}

module.exports = FollowingFooter
