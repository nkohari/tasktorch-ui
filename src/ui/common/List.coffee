React     = require 'react'
PropTypes = require 'ui/framework/PropTypes'
{ul}      = React.DOM

List = React.createClass {

  displayName: 'List'

  propTypes:
    isReady: PropTypes.func

  render: ->
    
    if not @props.isReady? or @props.isReady()
      children = @props.children
    else
      children = []

    ul @props, children

}

module.exports = List
