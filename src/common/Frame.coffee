React     = require 'react/addons'
PropTypes = require 'common/PropTypes'

Frame = React.createClass {

  displayName: 'Frame'

  propTypes:
    component: PropTypes.string
    isReady:   PropTypes.func

  getDefaultProps: ->
    {component: 'div'}

  render: ->
    component = React.DOM[@props.component]
    if not @props.isReady? or @props.isReady()
      component @props, @props.children
    else
      component @props, []

}

module.exports = Frame
