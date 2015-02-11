React     = require 'react/addons'
PropTypes = require 'framework/PropTypes'
{div}     = React.DOM

Frame = React.createClass {

  displayName: 'Frame'

  propTypes:
    isReady: PropTypes.func

  render: ->

    if not @props.isReady? or @props.isReady()
      children = @props.children
    else
      children = []

    div @props, children

}

module.exports = Frame
