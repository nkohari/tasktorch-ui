#--------------------------------------------------------------------------------
React     = require 'react'
PropTypes = require 'ui/framework/PropTypes'
{em}      = React.DOM
#--------------------------------------------------------------------------------

ActionWidget = React.createClass {

  displayName: 'ActionWidget'

  propTypes:
    action: PropTypes.Action

  render: ->
    em {className: 'action-widget'},
      @props.action?.text or 'a deleted action'

}

module.exports = ActionWidget
