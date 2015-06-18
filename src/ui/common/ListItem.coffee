React     = require 'react'
PropTypes = require 'ui/framework/PropTypes'
{li}      = React.DOM

ListItem = React.createClass {

  displayName: 'ListItem'

  propTypes:
    isReady: PropTypes.func

  render: ->
    
    if not @props.isReady? or @props.isReady()
      children = @props.children
    else
      children = []

    li @props, children

}

module.exports = ListItem
