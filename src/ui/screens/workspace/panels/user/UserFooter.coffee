#--------------------------------------------------------------------------------
React  = require 'react'
Pure   = require 'ui/framework/mixins/Pure'
Button = React.createFactory(require 'ui/common/Button')
{div}  = React.DOM
#--------------------------------------------------------------------------------

UserFooter = React.createClass {

  displayName: 'UserFooter'

  mixins: [Pure]

  render: ->
    div {className: 'footer'}

}

module.exports = UserFooter
