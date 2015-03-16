React  = require 'react'
Pure   = require 'ui/framework/mixins/Pure'
Button = React.createFactory(require 'ui/common/Button')
{div}  = React.DOM

StackFooter = React.createClass {

  displayName: 'StackFooter'

  mixins: [Pure]

  render: ->
    div {className: 'footer'}

}

module.exports = StackFooter
