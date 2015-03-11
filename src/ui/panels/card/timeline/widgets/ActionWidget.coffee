React     = require 'react'
PropTypes = require 'ui/framework/PropTypes'
{em}      = React.DOM

ActionWidget = React.createClass {

  displayName: 'ActionWidget'

  propTypes:
    action: PropTypes.Action

  render: ->
    em {}, @props.action.name

}

module.exports = ActionWidget
