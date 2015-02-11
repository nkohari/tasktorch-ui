React     = require 'react/addons'
PropTypes = require 'framework/PropTypes'
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
