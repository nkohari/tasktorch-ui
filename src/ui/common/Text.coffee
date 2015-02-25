React     = require 'react/addons'
PropTypes = require 'ui/framework/PropTypes'
{span}    = React.DOM

Text = React.createClass {

  displayName: 'Text'

  propTypes:
    isReady: PropTypes.func

  render: ->
    
    if not @props.isReady? or @props.isReady()
      children = @props.children
    else
      children = []

    span @props, children

}

module.exports = Text
